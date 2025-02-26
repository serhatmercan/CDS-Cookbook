CLASS ZSM_CL_AMDP DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      if_amdp_marker_hdb.

    CLASS-METHODS:
      get_amount            FOR TABLE FUNCTION zsm_f_amount,
      get_date              FOR TABLE FUNCTION zsm_f_date,
      get_material          FOR TABLE FUNCTION zsm_f_material,
      get_nomi_match        FOR TABLE FUNCTION zsm_f_nomi_match,
      get_nomi_match_prm    FOR TABLE FUNCTION zsm_f_nomi_match_prm,
      get_nomi_rows_no      FOR TABLE FUNCTION zsm_f_nomi_rows,
      get_risk_docs         FOR TABLE FUNCTION zsm_f_risk_docs,
      get_technical_object  FOR TABLE FUNCTION zsm_f_technical_object,
      get_working_days      FOR TABLE FUNCTION zsm_f_working_days,
      workdays_between      FOR TABLE FUNCTION zsm_f_workdays_between.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ZSM_CL_AMDP IMPLEMENTATION.
  METHOD get_amount BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING acdoca t006a.
    lt_data = SELECT DISTINCT t1.rclnt,
                              t1.rldnr,
                              t1.rbukrs,
                              t1.gjahr,
                              t1.belnr,
                              t1.docln,
                              t1.msl,
                              concat( t1.msl , t2.msehl ) as amount,
                              t1.mwskz
                         FROM acdoca AS t1
                   INNER JOIN t006a  AS t2 
                           ON t2.msehi = t1.runit
                        WHERE t1.rldnr  = '0L'
                          AND t1.rbukrs = : p_bukrs
                          AND t1.gjahr  = : p _gjahr
                          AND t1.ktosl  <> 'VST'
                          AND t1.koart  <> 'K'
                          AND t2.spras  =  'T';


    RETURN
      SELECT rclnt  as Client,
             rldnr  as Rldnr,
             rbukrs as Bukrs,
             gjahr  as Gjahr,
             belnr  as Belnr,
             mwskz  as Mwskz,
             STRING_AGG(amount,',' order by msl) as Amount
        FROM :lt_data
    GROUP BY rclnt,
             rldnr,
             rbukrs,
             gjahr,
             belnr,
             mwskz;                          
  ENDMETHOD.

  METHOD get_date BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING cdpos cdhdr.
    WITH lt_ranked_data AS ( SELECT cdpos.mandant  AS Client,
                                    cdhdr.objectid AS ObjectID,
                                    cdpos.tabkey   AS Tabkey,
                                    cdhdr.udate    AS Odate,
                                    cdhdr.utime    AS Otime,
                                    RANK() OVER ( PARTITION BY cdpos.mandant, cdpos.tabkey
                                                  ORDER BY cdhdr.udate DESC, cdhdr.utime DESC ) AS Rank
                              FROM cdhdr 
                        INNER JOIN cdpos 
                                ON cdhdr.objectclas = cdpos.objectclas
                               AND cdhdr.objectid   = cdpos.objectid
                               AND cdhdr.changenr   = cdpos.changenr
                             WHERE cdhdr.objectclas = 'BANF'
                               AND cdpos.tabname    = 'EBAN'
                               AND cdpos.fname      = 'FRGZU' )
    
    SELECT Client,
           ObjectID,
           Tabkey,
           Odate,
           Otime
      FROM lt_ranked_data
     WHERE Rank = 1;
  ENDMETHOD.

  METHOD get_material BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING mara makt.
    RETURN  WITH lt_mara AS ( SELECT * 
                                FROM APPLY_FILTER( mara, :p_sel_opt ) )
            SELECT mara.mandt AS Client, 
                   mara.matnr AS Matnr, 
                   makt.maktx AS Maktx
              FROM lt_mara AS mara
        INNER JOIN makt
                ON mara.mandt EQ makt.mandt
               AND mara.matnr EQ makt.matnr;
  ENDMETHOD.

  METHOD get_nomi_match BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING oijnomi oijpeg.
    declare v_count integer;
    declare v_i integer;
    declare nomtk "$ABAP.type( oij_nomtk )";
    declare item  "$ABAP.type( oij_item )";
    declare pegid "$ABAP.type( oij_pegid )";

    t_nomi =  SELECT oijnomi.mandt   AS Clnt,
                     oijnomi.nomtk   AS NominationDocDQ,
                     oijnomi.nomit   AS NominationdocItemDQ,
                     oijnomi.nomtk   AS NominationDocOQ,
                     oijnomi.nomit   AS NominationDocItemOQ,
                     oijnomi.sityp   AS Sityp,
                     oijnomi.docind  AS Docind,
                     oijnomi.delind  AS Delind
                FROM oijnomi
               WHERE oijnomi.mandt = :p_client
                 AND delind = '';

    t_oijpeg = SELECT oijpeg.pegid,
                      oijpeg.docno,
                      oijpeg.item,
                      oijnomi.sityp,
                      oijnomi.docind
                 FROM oijpeg
                 INNER JOIN oijnomi on oijnomi.nomtk = oijpeg.docno 
                                   and oijnomi.nomit = oijpeg.item;

    FOR v_i IN 1..record_count( :t_nomi ) DO
        nomtk = :t_nomi.NominationDocDQ[ :v_i ];
        item  = :t_nomi.NominationdocItemDQ[ :v_i ];

        lt_pegid = SELECT pegid 
                     FROM :t_oijpeg
                    WHERE docno = :p_nomtk
                      AND item  = :item;

        pegid = :lt_pegid.pegid[ 1 ];

        lt_item = SELECT item
                    FROM :t_oijpeg
                   WHERE pegid = :pegid
                     AND sityp LIKE 'O%';

        IF is_empty( :lt_item ) THEN
            IF NOT :t_nomi.sityp[ :v_i ] LIKE 'O%' THEN
                lt_oijnom = SELECT nominationdocdq,
                                   nominationdocitemdq,
                                   sityp,
                                   docind
                              FROM :t_nomi
                             WHERE nominationdocdq = :p_nomtk
                               AND nominationdocitemdq < :item
                               AND sityp LIKE 'O%'
                             ORDER BY nominationdocitemdq desc;

                t_nomi.nominationdocitemoq[ :v_i ] = :lt_oijnom.nominationdocitemdq[ 1 ];
            ELSE
                t_nomi.nominationdocitemoq[ :v_i ] = :t_nomi.nominationdocitemdq[ :v_i ];
            END IF;
        ELSE
            t_nomi.nominationdocitemoq[ :v_i ] = :lt_item.item[ 1 ];
        END IF;
    END FOR;

    RETURN 
        SELECT clnt,
               nominationdocdq,
               nominationdocitemdq,
               nominationdocoq,
               nominationdocitemoq,
               sityp  AS nominationscheduletype,
               docind AS nominationreferencedoctype
          FROM :t_nomi
         WHERE sityp like 'D%'
        UNION ALL
        SELECT clnt,
               '' nominationdocdq,
               '' nominationdocitemdq,
               nominationdocoq,
               nominationdocitemoq,
               sityp  AS nominationscheduletype,
               docind AS nominationreferencedoctype
          FROM :t_nomi n1
          WHERE n1.sityp LIKE 'O%'
            AND NOT EXISTS ( SELECT *
                               FROM :t_nomi n2
                              WHERE n2.nominationdocoq     = n1.nominationdocoq
                                AND n2.nominationdocitemoq = n1.nominationdocitemoq
                                AND sityp LIKE 'D%' );

  ENDMETHOD.

  METHOD get_nomi_match_prm BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING oijnomi oijpeg.
    declare v_count integer;
    declare v_i integer;
    declare nomtk "$ABAP.type( oij_nomtk )";
    declare item  "$ABAP.type( oij_item )";
    declare pegid "$ABAP.type( oij_pegid )";

    t_nomi =  SELECT mandt  AS Clnt,
                     nomtk  AS NominationDocDQ,
                     nomit  AS NominationdocItemDQ,
                     nomtk  AS NominationDocOQ,
                     nomit  AS NominationDocItemOQ,
                     sityp  AS Sityp,
                     docind AS Docind,
                     delind AS Delind
                FROM oijnomi
               WHERE oijnomi.mandt = :p_client
                 AND delind = '';

    SELECT COUNT(*)
      FROM :t_nomi 
      INTO v_count;

    t_oijpeg = SELECT oijpeg.pegid,
                      oijpeg.docno,
                      oijpeg.item,
                      oijnomi.sityp,
                      oijnomi.docind
                 FROM oijpeg
                 INNER JOIN oijnomi ON oijnomi.nomtk = oijpeg.docno 
                                   AND oijnomi.nomit = oijpeg.item;

    FOR v_i IN 1..record_count( :t_nomi ) DO
        nomtk = :t_nomi.nominationdocdq[ :v_i ];
        item  = :t_nomi.nominationdocitemdq[ :v_i ];

        lt_pegid = SELECT pegid 
                     FROM :t_oijpeg
                    WHERE docno = :p_nomtk
                      AND item  = :item;

        pegid = :lt_pegid.pegid[ 1 ];

        lt_item = SELECT item
                    FROM :t_oijpeg
                   WHERE pegid = :pegid
                     AND sityp LIKE 'O%';

        IF is_empty( :lt_item ) THEN
            IF NOT :t_nomi.sityp[ :v_i ] like 'O%' THEN
                lt_oijnom = SELECT nominationdocdq,
                                   nominationdocitemdq,
                                   sityp,
                                   docind
                              FROM :t_nomi
                             WHERE nominationdocdq = :p_nomtk
                               AND nominationdocitemdq < :item
                               AND sityp LIKE 'O%'
                          ORDER BY nominationdocitemdq DESC;

                t_nomi.nominationdocitemoq[ :v_i ] = :lt_oijnom.nominationdocitemdq[ 1 ];
            ELSE
                t_nomi.nominationdocitemoq[ :v_i ] = :t_nomi.nominationdocitemdq[ :v_i ];
            END IF;
        ELSE
            t_nomi.nominationdocitemoq[ :v_i ] = :lt_item.item[ 1 ];
        END IF;
    END FOR;

    RETURN 
      SELECT clnt as Client,
             nominationdocdq,
             nominationdocitemdq,
             nominationdocoq,
             nominationdocitemoq,
             sityp  AS nominationscheduletype,
             docind AS nominationreferencedoctype
        FROM :t_nomi
       WHERE sityp LIKE 'D%'
      UNION ALL
      SELECT clnt as Client,
             '' nominationdocdq,
             '' nominationdocitemdq,
             nominationdocoq,
             nominationdocitemoq,
             sityp  AS nominationscheduletype,
             docind AS nominationreferencedoctype
       FROM :t_nomi t1
       WHERE NOT EXISTS ( SELECT *
                            FROM :t_nomi t2
                            WHERE t2.nominationdocdq = t1.nominationdocdq
                              AND sityp LIKE 'D%' );
  ENDMETHOD.

  METHOD get_nomi_rows_no BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zsm_i_nomi_match.

    t_nomi =  SELECT p_client as Mandt,
                     NominationDocDQ,
                     NominationDocItemDQ,
                     NominationDocOQ,
                     NominationDocItemOQ,
                     NominationScheduleType,
                     NominationReferenceDocType,
                     NominationScheduleTypeO,
                     NominationReferenceDocTypeO,
                ROW_NUMBER(  ) 
                OVER ( PARTITION BY nominationdocoq,nominationdocitemoq ORDER BY nominationdocdq,nominationdocitemdq,nominationdocoq,nominationdocitemoq ) as RowNo
                FROM zsm_i_nomi_match;

    RETURN SELECT Mandt as Client,
                  NominationDocDQ,
                  NominationDocItemDQ,
                  NominationDocOQ,
                  NominationDocItemOQ,
                  NominationScheduleType,
                  NominationReferenceDocType,
                  NominationScheduleTypeO,
                  NominationReferenceDocTypeO,
                  RowNo
             FROM :t_nomi;
  ENDMETHOD.

  METHOD get_risk_docs BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zsm_i_risk_docs.
    RETURN SELECT DISTINCT p_client                                                      as Client,
                           docno                                                         as DocNo,
                           docitemno                                                     as DocItemNo,
                           docitemguid                                                   as DocItemGuid,
                           pricebegintime                                                as PriceBeginTime,
                           pricebegindate                                                as PriceBeginDate,
                           priceendtime                                                  as PriceEndTime,
                           priceenddate                                                  as PriceEndDate,
                           workdays_between( 'PI', pricebegindate, priceenddate ) + 1    as WorkingDay
                      FROM zsm_i_risk_docs;
  ENDMETHOD.

  METHOD get_technical_object BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zsm_t_user_to iflot.
    declare gt_temp_user_to TABLE ( client   "$ABAP.type( MANDT )",
                                    user     "$ABAP.type( XUBNAME )",
                                    tplnr    "$ABAP.type( TPLNR )",
                                    werks    "$ABAP.type( WERKS_D )",
                                    sub_hier "$ABAP.type( XFELD )" 
                                  );

     declare lv_index integer;
     declare lv_line integer;
     declare lv_index1 integer;
     declare lv_line1 integer;
     declare lv_add_index integer;

     declare gt_temp_user_to2 TABLE LIKE :gt_temp_user_to;
     declare gt_temp_user_to3 TABLE LIKE :gt_temp_user_to;

     gt_user_to = SELECT t1.mandt,
                         t1.bname,
                         t1.tplnr,
                         t1.werks,
                         CASE t3.tplnr WHEN '' THEN ''
                                               ELSE 'X'
                         END AS sub_hier
                    FROM zsm_t_user_to  AS t1
              INNER JOIN iflot          AS t2 on t2.tplnr EQ t1.tplnr and t2.mandt EQ t1.mandt
         LEFT OUTER JOIN iflot          AS t3 on t3.tplnr EQ t2.tplma and t3.mandt EQ t1.mandt
                   WHERE t1.mandt EQ p_client
                     AND t1.bname EQ p_bname;
      
      lv_index = 1;
      lv_line  = record_count( :gt_user_to );
      
      IF lv_line <> 0 then
          WHILE lv_index BETWEEN 1 AND lv_line DO

            gt_temp_user_to3.client[ 1 ]    = :gt_user_to.mandt[ :lv_index ];
            gt_temp_user_to3.user[ 1 ]      = :gt_user_to.bname[ :lv_index ];
            gt_temp_user_to3.werks[ 1 ]     = :gt_user_to.werks[ :lv_index ];
            gt_temp_user_to3.tplnr[ 1 ]     = :gt_user_to.tplnr[ :lv_index ];
            gt_temp_user_to3.sub_hier[ 1 ]  = :gt_user_to.sub_hier[ :lv_index ];

            gt_temp_user_to2 = SELECT t1.client, t1.user, t1.tplnr, t1.werks,  t1.sub_hier
                                 FROM :gt_temp_user_to  AS t1
                           INNER JOIN :gt_temp_user_to3 AS t2 
                                   ON t2.client EQ t1.client
                                  AND t2.user   EQ t1.user
                                  AND t2.werks  EQ t1.werks
                                  AND t2.tplnr  EQ t1.tplnr;

            lv_line1 = record_count( :gt_temp_user_to2 );
            
            IF lv_line1 = 0 THEN

              gt_temp_user_to.client[ :lv_index ]   = :gt_user_to.mandt[ :lv_index ];
              gt_temp_user_to.user[ :lv_index ]     = :gt_user_to.bname[ :lv_index ];
              gt_temp_user_to.werks[ :lv_index ]    = :gt_user_to.werks[ :lv_index ];
              gt_temp_user_to.tplnr[ :lv_index ]    = :gt_user_to.tplnr[ :lv_index ];
              gt_temp_user_to.sub_hier[ :lv_index ] = :gt_user_to.sub_hier[ :lv_index ];


              gt_temp_user_to2 = SELECT *
                                  FROM :gt_temp_user_to
                                  WHERE sub_hier EQ 'X';
            
              lv_index1 = 1;
              lv_line1  = record_count( :gt_temp_user_to2 );
              
              IF lv_line1 <> 0 THEN
                gt_sub_tplnr = SELECT t1.mandt,
                                      t1.tplnr,
                                      CASE t3.tplnr WHEN '' THEN ''
                                                            ELSE 'X'
                                      END AS sub_hier
                                FROM iflot AS t1
                          INNER JOIN :gt_temp_user_to2 AS t2 
                                  ON t2.tplnr EQ t1.tplma
                      LEFT OUTER JOIN iflot AS t3 
                                  ON t3.tplma = t1.tplnr 
                                  AND t3.mandt = t1.mandt
                                WHERE t1.mandt = p_client;

                lv_line1 = record_count( :gt_temp_user_to );

                  WHILE lv_index1 BETWEEN 1 AND lv_line1 DO
                      IF :gt_temp_user_to.sub_hier[ :lv_index1 ] = 'X' THEN
                          gt_temp_user_to.sub_hier[ :lv_index1 ] = '';
                      END IF;
                      lv_index1 = :lv_index1 + 1;
                  END WHILE ;
              END IF;

              lv_index1 = 1;
              lv_line1  = record_count( :gt_sub_tplnr );

              IF lv_line1 <> 0 THEN
                WHILE lv_index1 BETWEEN 1 AND lv_line1 DO
                  lv_add_index = record_count( :gt_user_to ) + 1;
                  
                  gt_user_to.mandt[ :lv_add_index ]    = :gt_user_to.mandt[ :lv_index ];
                  gt_user_to.bname[ :lv_add_index ]    = :gt_user_to.bname[ :lv_index ];
                  gt_user_to.werks[ :lv_add_index ]    = :gt_user_to.werks[ :lv_index ];
                  gt_user_to.tplnr[ :lv_add_index ]    = :gt_sub_tplnr.tplnr[ :lv_index1 ];
                  gt_user_to.sub_hier[ :lv_add_index ] = :gt_sub_tplnr.sub_hier[ :lv_index1 ];

                  lv_index1 = :lv_index1 + 1;
                END WHILE;
              END IF;
            END IF;
            
            lv_line = record_count( :gt_user_to );
            
            gt_sub_tplnr = SELECT * FROM :gt_sub_tplnr WHERE mandt = '000';
            
            lv_index = :lv_index + 1;
          END WHILE;
      END IF;

      RETURN SELECT clnt  as Client,
                    werks as Werks,
                    user  as Bname,
                    tplnr as Tplnr
               FROM :gt_temp_user_to;
  ENDMETHOD.

  METHOD get_working_days BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING i_calendardate.
    t_calendar = SELECT p_client                                                                                      as Client,
                        ID.calendardate                                                                               as CalendarDate,
                        p_fabkl                                                                                       as FactoryCalendar,
                        ID.firstdayofmonthdate                                                                        as MonthFirstDate,
                        last_day( ID.calendardate )                                                                   as MonthLastDate,
                        workdays_between( p_fabkl, ID.firstdayofmonthdate, add_months( ID.firstdayofmonthdate,1  ) )  as WorkingDaySmonth,
                        workdays_between( p_fabkl, ID.calendardate, dats_add_days(ID.calendardate,1,'INITIAL')  )     as IsWorkingDay
                   FROM i_calendardate                                                                                as ID;

    RETURN SELECT Client,
                  CalendarDate,
                  FactoryCalendar,
                  MonthFirstDate,
                  MonthLastDate,
                  WorkingDaySmonth,
                  IsWorkingDay
             FROM :t_calendar
            WHERE IsWorkingDay <> 0;
  ENDMETHOD.

  METHOD workdays_between BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    RETURN SELECT p_client    as Client,
                  p_first_day as FirstDay,
                  p_last_day  as LastDay,
                  workdays_between( p_calendar, p_fday, p_lday ) + 1 as Workday
             FROM dummy;
  ENDMETHOD.
ENDCLASS.