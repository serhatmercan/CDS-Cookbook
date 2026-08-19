" ============================================================================
" Type       : AMDP (class implementing CDS table functions)
" Context    : reusable pattern
" Class      : ZSM_CL_AMDP
" Module     : cross-application
" ----------------------------------------------------------------------------
" Description
"   AMDP class (IF_AMDP_MARKER_HDB) holding the SQLScript implementations of
"   the CDS table functions declared in AMDP/Function.abap.
"
" Methods
"   - get_quantity_list    : STRING_AGG over ACDOCA, quantity + unit text per
"                            accounting document
"   - get_change_date      : RANK() window function - latest change document
"                            entry per table key (CDHDR/CDPOS)
"   - get_material         : APPLY_FILTER with an explicit trust boundary
"   - get_nomi_match       : set-based nomination / pegging join with
"                            ROW_NUMBER de-duplication (OIJNOMI/OIJPEG)
"   - get_nomi_rows_no     : ROW_NUMBER over a consuming CDS view
"   - get_risk_docs        : WORKDAYS_BETWEEN over price validity dates
"   - get_technical_object : recursive CTE walking the functional location
"                            hierarchy (IFLOT) below a user's assignments
"   - get_working_days     : bounded calendar read with working-day flags
"   - workdays_between     : thin wrapper over the WORKDAYS_BETWEEN built-in
"
" SQLScript patterns demonstrated
"   window functions (RANK, ROW_NUMBER) - STRING_AGG with ORDER BY -
"   common table expressions - recursive CTE hierarchy traversal -
"   APPLY_FILTER with a generated condition - typed table variables -
"   HANA date functions (WORKDAYS_BETWEEN, ADD_MONTHS, LAST_DAY,
"   DATS_ADD_DAYS)
"
" Client safety (applies to EVERY method here)
"   Each client-dependent table is restricted with :p_client, and every join
"   between client-dependent tables carries the client column. See
"   AMDP/Function.abap for the matching client-handling annotations and the
"   release note. A missing client predicate in an AMDP method is a
"   cross-client read: the CDS layer cannot add it for you.
"
" Release note
"   get_technical_object uses a recursive common table expression
"   (WITH RECURSIVE), which requires a HANA release that supports it. Verify
"   support on your target database before copying that recipe.
"
" Comment-syntax note
"   This file is ABAP, so ABAP " comments are correct here. Files whose
"   content is CDS DDL use // comments instead.
"
" Related
"   AMDP/Function.abap
" ============================================================================

CLASS zsm_cl_amdp DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_quantity_list    FOR TABLE FUNCTION zsm_f_quantity_list.
    CLASS-METHODS get_change_date      FOR TABLE FUNCTION zsm_f_change_date.
    CLASS-METHODS get_material         FOR TABLE FUNCTION zsm_f_material.
    CLASS-METHODS get_nomi_match       FOR TABLE FUNCTION zsm_f_nomi_match.
    CLASS-METHODS get_nomi_rows_no     FOR TABLE FUNCTION zsm_f_nomi_rows.
    CLASS-METHODS get_risk_docs        FOR TABLE FUNCTION zsm_f_risk_docs.
    CLASS-METHODS get_technical_object FOR TABLE FUNCTION zsm_f_technical_object.
    CLASS-METHODS get_working_days     FOR TABLE FUNCTION zsm_f_working_days.
    CLASS-METHODS workdays_between     FOR TABLE FUNCTION zsm_f_workdays_between.
ENDCLASS.


CLASS zsm_cl_amdp IMPLEMENTATION.

  " --------------------------------------------------------------------------
  " STRING_AGG: collapse the quantity + unit text of every document line into
  " one comma-separated string per accounting document.
  " Ledger '0L' is the standard leading ledger, not customer configuration.
  " --------------------------------------------------------------------------
  METHOD get_quantity_list BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                           OPTIONS READ-ONLY
                           USING acdoca t006a.

    lt_line = SELECT DISTINCT t1.rclnt,
                              t1.rldnr,
                              t1.rbukrs,
                              t1.gjahr,
                              t1.belnr,
                              t1.docln,
                              t1.mwskz,
                              concat( t1.msl, t2.msehl ) AS qty_text
                         FROM acdoca AS t1
                   INNER JOIN t006a  AS t2
                           ON  t2.mandt = t1.rclnt
                          AND  t2.msehi = t1.runit
                          AND  t2.spras = :p_langu
                        WHERE t1.rclnt  = :p_client
                          AND t1.rldnr  = '0L'
                          AND t1.rbukrs = :p_bukrs
                          AND t1.gjahr  = :p_gjahr;

    RETURN SELECT rclnt                                        AS Client,
                  rldnr                                        AS Ledger,
                  rbukrs                                       AS CompanyCode,
                  gjahr                                        AS FiscalYear,
                  belnr                                        AS Document,
                  mwskz                                        AS TaxCode,
                  string_agg( qty_text, ',' ORDER BY docln )    AS QuantityList
             FROM :lt_line
         GROUP BY rclnt,
                  rldnr,
                  rbukrs,
                  gjahr,
                  belnr,
                  mwskz;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " RANK() window function: newest change document entry per table key.
  " Object class, table and field name are parameters - the recipe is not
  " bound to one business object.
  " --------------------------------------------------------------------------
  METHOD get_change_date BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                         OPTIONS READ-ONLY
                         USING cdhdr cdpos.

    RETURN WITH lt_ranked AS ( SELECT h.mandant  AS client,
                                      h.objectid AS objectid,
                                      p.tabkey   AS tabkey,
                                      h.udate    AS udate,
                                      h.utime    AS utime,
                                      RANK( ) OVER ( PARTITION BY h.mandant, p.tabkey
                                                     ORDER BY h.udate DESC, h.utime DESC ) AS latest_rank
                                 FROM cdhdr AS h
                           INNER JOIN cdpos AS p
                                   ON  p.mandant    = h.mandant
                                  AND  p.objectclas = h.objectclas
                                  AND  p.objectid   = h.objectid
                                  AND  p.changenr   = h.changenr
                                WHERE h.mandant    = :p_client
                                  AND h.objectclas = :p_object_class
                                  AND p.tabname    = :p_table_name
                                  AND p.fname      = :p_field_name )

           SELECT client   AS Client,
                  objectid AS ObjectID,
                  tabkey   AS TableKey,
                  udate    AS ChangeDate,
                  utime    AS ChangeTime
             FROM lt_ranked
            WHERE latest_rank = 1;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " APPLY_FILTER - SECURITY BOUNDARY
  "
  " APPLY_FILTER attaches a dynamic WHERE condition to a data source. SAP's
  " own security documentation names it as an SQL-injection vector when the
  " condition is combined with input from outside that is not validated
  " appropriately. Parsing the string is NOT validation.
  "
  " Therefore :p_filter_condition must be a condition GENERATED on the ABAP
  " side from structured input (select-options / RANGE tables), for example
  " with CL_SHDB_SELTAB=>COMBINE_SELTABS( ), which turns typed selection
  " tables into a WHERE fragment. Verify the availability and signature of
  " that class for your target release.
  "
  " Never accept a condition string supplied by a consumer, a UI, an OData
  " query option, or any other external caller and pass it here unchanged.
  " If you cannot guarantee the string was generated from validated
  " structured input, do not use this pattern.
  " --------------------------------------------------------------------------
  METHOD get_material BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                      OPTIONS READ-ONLY
                      USING mara makt.

    RETURN WITH lt_mara AS ( SELECT *
                               FROM APPLY_FILTER( mara, :p_filter_condition ) )

           SELECT m.mandt AS Client,
                  m.matnr AS Material,
                  t.maktx AS MaterialName
             FROM lt_mara AS m
       INNER JOIN makt     AS t
               ON  t.mandt = m.mandt
              AND  t.matnr = m.matnr
              AND  t.spras = :p_langu
            WHERE m.mandt = :p_client;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " Set-based nomination / pegging join.
  "
  " Business-rule note: an earlier revision walked every nomination line in a
  " FOR loop to derive a demand/offer pairing by searching backwards for the
  " nearest preceding offer item. That rule was project-specific, and two
  " variants of this method contradicted each other, so the pairing rule is
  " deliberately NOT reproduced here rather than guessed. What remains is the
  " structurally safe part: the client-correct OIJNOMI/OIJPEG pegging join
  " with ROW_NUMBER de-duplication. Add your own pairing rule on top.
  " --------------------------------------------------------------------------
  METHOD get_nomi_match BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                        OPTIONS READ-ONLY
                        USING oijnomi oijpeg.

    -- An empty p_nomit means "all items of the document".
    lt_nomi = SELECT n.mandt  AS client,
                     n.nomtk  AS nomtk,
                     n.nomit  AS nomit,
                     n.sityp  AS sityp,
                     n.docind AS docind
                FROM oijnomi AS n
               WHERE n.mandt  = :p_client
                 AND n.delind = ''
                 AND n.nomtk  = :p_nomtk
                 AND ( :p_nomit = '' OR n.nomit = :p_nomit );

    -- One pegging record per nomination item; ROW_NUMBER keeps the result
    -- unique when an item carries several pegging entries.
    lt_peg = SELECT g.mandt AS client,
                    g.docno AS docno,
                    g.item  AS item,
                    g.pegid AS pegid,
                    ROW_NUMBER( ) OVER ( PARTITION BY g.mandt, g.docno, g.item
                                         ORDER BY g.pegid ) AS peg_row
               FROM oijpeg AS g
              WHERE g.mandt = :p_client
                AND g.docno = :p_nomtk;

    RETURN SELECT n.client                  AS Client,
                  n.nomtk                   AS NominationDoc,
                  n.nomit                   AS NominationDocItem,
                  coalesce( p.pegid, '' )   AS PeggingID,
                  n.sityp                   AS NominationScheduleType,
                  n.docind                  AS NominationReferenceDocType
             FROM :lt_nomi AS n
  LEFT OUTER JOIN :lt_peg  AS p
               ON  p.client  = n.client
              AND  p.docno   = n.nomtk
              AND  p.item    = n.nomit
              AND  p.peg_row = 1;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " ROW_NUMBER over a consuming CDS view.
  " A CDS entity may be used as an AMDP data source and listed in USING.
  " Dependency: ZSM_I_NOMI_MATCH is the CDS view that consumes
  " ZSM_F_NOMI_MATCH and exposes its elements (Client first).
  " --------------------------------------------------------------------------
  METHOD get_nomi_rows_no BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                          OPTIONS READ-ONLY
                          USING zsm_i_nomi_match.

    lt_match = SELECT m.client                     AS client,
                      m.nominationdoc              AS nominationdoc,
                      m.nominationdocitem          AS nominationdocitem,
                      m.peggingid                  AS peggingid,
                      m.nominationscheduletype     AS nominationscheduletype,
                      m.nominationreferencedoctype AS nominationreferencedoctype,
                      ROW_NUMBER( ) OVER ( PARTITION BY m.nominationdoc
                                           ORDER BY m.nominationdocitem ) AS row_no
                 FROM zsm_i_nomi_match AS m
                WHERE m.client = :p_client;

    RETURN SELECT client                     AS Client,
                  nominationdoc              AS NominationDoc,
                  nominationdocitem          AS NominationDocItem,
                  peggingid                  AS PeggingID,
                  nominationscheduletype     AS NominationScheduleType,
                  nominationreferencedoctype AS NominationReferenceDocType,
                  row_no                     AS RowNo
             FROM :lt_match;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " WORKDAYS_BETWEEN over price validity dates.
  " The factory calendar is a parameter, not a literal.
  " "+ 1" makes the interval inclusive of the end date - drop it if your
  " business definition is exclusive.
  " Dependency: ZSM_I_RISK_DOCS exposes the price validity dates per
  " condition document item, with a Client element.
  " --------------------------------------------------------------------------
  METHOD get_risk_docs BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                       OPTIONS READ-ONLY
                       USING zsm_i_risk_docs.

    RETURN SELECT DISTINCT
                  d.client                                                          AS Client,
                  d.docno                                                           AS DocNo,
                  d.docitemno                                                       AS DocItemNo,
                  d.docitemguid                                                     AS DocItemGuid,
                  d.pricebegindate                                                  AS PriceBeginDate,
                  d.priceenddate                                                    AS PriceEndDate,
                  workdays_between( :p_calendar, d.pricebegindate, d.priceenddate ) + 1
                                                                                    AS WorkingDays
             FROM zsm_i_risk_docs AS d
            WHERE d.client = :p_client;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " Recursive CTE hierarchy traversal.
  "
  " Starts from the functional locations assigned to the user in
  " ZSM_T_USER_TO and descends the IFLOT superior-location hierarchy
  " (IFLOT-TPLMA points to the superior functional location).
  "
  " An earlier revision did this with nested WHILE loops that appended to the
  " very table they were iterating, read an uninitialised table variable, and
  " indexed table variables without an emptiness guard. The recursive CTE
  " replaces all of that and terminates on the depth guard below.
  "
  " Depth is bounded (hlevel < 10) so a cyclic or unexpectedly deep
  " hierarchy cannot run away. Raise or lower it to fit your hierarchy.
  " --------------------------------------------------------------------------
  METHOD get_technical_object BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                              OPTIONS READ-ONLY
                              USING zsm_t_user_to iflot.

    RETURN WITH RECURSIVE lt_hier ( client, bname, werks, tplnr, hlevel ) AS (

             -- Anchor: the functional locations directly assigned to the user
             SELECT u.mandt,
                    u.bname,
                    u.werks,
                    u.tplnr,
                    0
               FROM zsm_t_user_to AS u
         INNER JOIN iflot         AS f
                 ON  f.mandt = u.mandt
                AND  f.tplnr = u.tplnr
              WHERE u.mandt = :p_client
                AND u.bname = :p_bname

             UNION ALL

             -- Recursion: every functional location below the current one
             SELECT h.client,
                    h.bname,
                    h.werks,
                    f.tplnr,
                    h.hlevel + 1
               FROM lt_hier AS h
         INNER JOIN iflot   AS f
                 ON  f.mandt = h.client
                AND  f.tplma = h.tplnr
              WHERE h.hlevel < 10
           )

           SELECT client AS Client,
                  bname  AS UserName,
                  werks  AS Plant,
                  tplnr  AS FunctionalLocation,
                  hlevel AS HierarchyLevel
             FROM lt_hier;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " Bounded calendar read with working-day flags.
  " The date range is a parameter pair: reading the whole calendar view is
  " not a reasonable reusable default.
  " IsWorkingDay is a genuine flag here - the result is NOT pre-filtered to
  " working days, so the caller can use it in either direction.
  " --------------------------------------------------------------------------
  METHOD get_working_days BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                          OPTIONS READ-ONLY
                          USING i_calendardate.

    lt_calendar = SELECT :p_client                                   AS client,
                         d.calendardate                             AS calendardate,
                         :p_calendar                                 AS fabkl,
                         d.firstdayofmonthdate                      AS month_first,
                         last_day( d.calendardate )                 AS month_last,
                         workdays_between( :p_calendar,
                                           d.firstdayofmonthdate,
                                           add_months( d.firstdayofmonthdate, 1 ) ) AS wd_in_month,
                         workdays_between( :p_calendar,
                                           d.calendardate,
                                           dats_add_days( d.calendardate, 1, 'INITIAL' ) ) AS is_working_day
                    FROM i_calendardate AS d
                   WHERE d.calendardate BETWEEN :p_date_from AND :p_date_to;

    RETURN SELECT client         AS Client,
                  calendardate   AS CalendarDate,
                  fabkl          AS FactoryCalendar,
                  month_first    AS MonthFirstDate,
                  month_last     AS MonthLastDate,
                  wd_in_month    AS WorkingDaysInMonth,
                  is_working_day AS IsWorkingDay
             FROM :lt_calendar;
  ENDMETHOD.


  " --------------------------------------------------------------------------
  " Thin wrapper exposing the WORKDAYS_BETWEEN built-in as a table function,
  " so plain CDS views can consume it. SELECT ... FROM dummy returns exactly
  " one row.
  " --------------------------------------------------------------------------
  METHOD workdays_between BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                          OPTIONS READ-ONLY.

    RETURN SELECT :p_client                                                  AS Client,
                  :p_date_from                                               AS DateFrom,
                  :p_date_to                                                 AS DateTo,
                  workdays_between( :p_calendar, :p_date_from, :p_date_to ) + 1
                                                                             AS WorkingDays
             FROM dummy;
  ENDMETHOD.

ENDCLASS.
