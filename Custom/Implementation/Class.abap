" ============================================================================
" Type       : ABAP snippet (query-provider class recipe)
" Context    : reusable pattern
" Class      : ZSM_CL_IM_QUERY  (query provider for custom entities)
" Module     : MM
" Business Object : Purchase Order
" ----------------------------------------------------------------------------
" Description
"   Implements IF_RAP_QUERY_PROVIDER~SELECT for custom entities that have no
"   database source, dispatching by entity ID:
"
"     ZSM_C_PO       -> _get_data           : freeform SQL over EKKO/EKPO/EKET
"                                             with request-driven filtering,
"                                             sorting and paging, plus payment
"                                             terms / document type text
"                                             enrichment and optional
"                                             reporting-currency conversion
"     ZSM_C_PO_ITEM  -> _get_goods_movement : material document lookup joined
"                                             to movement type texts
"
" Patterns demonstrated
"   - IF_RAP_QUERY_PROVIDER~SELECT with entity dispatch
"   - request handling: get_filter( )->get_as_ranges( ), get_sort_elements( ),
"     get_paging( ), is_data_requested( ), is_total_numb_of_rec_requested( )
"   - converting request ranges into typed ABAP range tables (an empty range
"     table means "no restriction" in an IN clause, so no branching is needed)
"   - dynamic ORDER BY assembled only from framework-supplied element names
"   - paging pushed into the database via UP TO / OFFSET, with an explicit
"     fallback page size instead of relying on "UP TO 0 ROWS"
"   - reporting-currency conversion driven by a caller-supplied currency
"
" Comment-syntax note
"   This file is ABAP, so ABAP " comments are correct here. Files whose
"   content is CDS DDL use // comments instead.
"
" Scope note
"   This file is ONE valid class. An earlier revision collected several
"   IF_RAP_QUERY_PROVIDER~SELECT bodies plus a remote-OData proxy recipe in a
"   single class, which could not compile. Two recipes were removed rather
"   than repaired:
"     - the remote destination / OData client proxy recipe: an ABAP-Cloud
"       oriented outlier in an on-premise CDS/AMDP cookbook, and its
"       provenance could not be established with confidence, so it is neither
"       kept unattributed nor given an invented attribution;
"     - a commodity/CPE nomination enrichment recipe: it depended on
"       project-specific views and business rules that cannot be genericised
"       without inventing logic.
"
" Dependencies
"   ZSM_TT_0001 / ZSM_TT_0002 - table types matching the custom entity
"   element lists (replace with your own).
"
" Paired with
"   Custom/Implementation/CDS.abap - the custom entity ZSM_C_PO, which
"   declares @ObjectModel.query.implementedBy: 'ABAP:ZSM_CL_IM_QUERY'.
" ============================================================================

CLASS zsm_cl_im_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.

  PRIVATE SECTION.
    CONSTANTS: c_entity_header TYPE string VALUE 'ZSM_C_PO',
               c_entity_item   TYPE string VALUE 'ZSM_C_PO_ITEM'.

    " Fallback page size used when the request does not supply a positive one.
    CONSTANTS c_max_page_size TYPE i VALUE 1000.

    METHODS _get_data
      IMPORTING
        !io_request        TYPE REF TO if_rap_query_request
        !iv_local_currency TYPE waers OPTIONAL
      EXPORTING
        !et_data           TYPE zsm_tt_0001.

    METHODS _get_goods_movement
      IMPORTING
        !io_filter TYPE REF TO if_rap_query_filter
      EXPORTING
        !et_data   TYPE zsm_tt_0002.
ENDCLASS.


CLASS zsm_cl_im_query IMPLEMENTATION.

  METHOD if_rap_query_provider~select.
    " Total record count note
    "   SET_TOTAL_NUMBER_OF_RECORDS( ) below counts the rows already returned
    "   by the read method. For ZSM_C_PO the read is paged in the database, so
    "   the value reports the page, not the full hit count. This is a
    "   simplified cookbook example. A productive
    "   implementation should determine the total count before paging (for
    "   example with a separate COUNT(*) SELECT using the same WHERE clause)
    "   whenever the consumer requests it.
    CASE io_request->get_entity_id( ).

      WHEN c_entity_header.
        _get_data( EXPORTING io_request = io_request
                   IMPORTING et_data    = DATA(lt_header) ).

        IF io_request->is_total_numb_of_rec_requested( ).
          io_response->set_total_number_of_records( lines( lt_header ) ).
        ENDIF.

        IF io_request->is_data_requested( ).
          io_response->set_data( lt_header ).
        ENDIF.

      WHEN c_entity_item.
        _get_goods_movement( EXPORTING io_filter = io_request->get_filter( )
                             IMPORTING et_data   = DATA(lt_item) ).

        IF io_request->is_total_numb_of_rec_requested( ).
          io_response->set_total_number_of_records( lines( lt_item ) ).
        ENDIF.

        IF io_request->is_data_requested( ).
          io_response->set_data( lt_item ).
        ENDIF.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_rap_query_prov_not_impl.

    ENDCASE.
  ENDMETHOD.


  METHOD _get_data.
    DATA: lr_ebeln  TYPE RANGE OF ebeln,
          lr_bsart  TYPE RANGE OF bsart,
          lr_aedat  TYPE RANGE OF aedat,
          lr_ernam  TYPE RANGE OF ernam,
          lr_ekorg  TYPE RANGE OF ekorg,
          lr_matnr  TYPE RANGE OF matnr,
          lr_werks  TYPE RANGE OF werks_d,
          lr_bukrs  TYPE RANGE OF bukrs,
          lv_orderby TYPE string,
          lv_prefix  TYPE string.

    CLEAR et_data.

    " ---- Filters: request ranges -> typed range tables ----------------------
    " An unfilled range table places no restriction on an IN clause, so every
    " filter below is optional without extra branching. Add further elements
    " to the CASE the same way.
    LOOP AT io_request->get_filter( )->get_as_ranges( ) INTO DATA(ls_filter).
      CASE ls_filter-name.
        WHEN 'EBELN'. lr_ebeln = CORRESPONDING #( ls_filter-range ).
        WHEN 'BSART'. lr_bsart = CORRESPONDING #( ls_filter-range ).
        WHEN 'AEDAT'. lr_aedat = CORRESPONDING #( ls_filter-range ).
        WHEN 'ERNAM'. lr_ernam = CORRESPONDING #( ls_filter-range ).
        WHEN 'EKORG'. lr_ekorg = CORRESPONDING #( ls_filter-range ).
        WHEN 'MATNR'. lr_matnr = CORRESPONDING #( ls_filter-range ).
        WHEN 'WERKS'. lr_werks = CORRESPONDING #( ls_filter-range ).
        WHEN 'BUKRS'. lr_bukrs = CORRESPONDING #( ls_filter-range ).
      ENDCASE.
    ENDLOOP.

    " ---- Sorting: build ORDER BY from framework element names ---------------
    " Only element names delivered by the request are used, mapped onto the
    " join aliases. No caller-supplied text is concatenated into SQL.
    LOOP AT io_request->get_sort_elements( ) INTO DATA(ls_sort).
      CASE ls_sort-element_name.
        WHEN 'EBELN' OR 'BEDAT' OR 'BSART' OR 'AEDAT' OR 'LIFNR'
          OR 'ZTERM' OR 'WAERS'.
          lv_prefix = `k~`.
        WHEN 'EBELP' OR 'MATNR' OR 'TXZ01' OR 'WERKS' OR 'LGORT' OR 'MENGE'
          OR 'PEINH' OR 'MEINS' OR 'NETPR' OR 'NETWR' OR 'ELIKZ' OR 'BUKRS'.
          lv_prefix = `p~`.
        WHEN 'ETENR' OR 'EINDT'.
          lv_prefix = `t~`.
        WHEN OTHERS.
          lv_prefix = `k~`.
      ENDCASE.

      DATA(lv_direction) = COND string( WHEN ls_sort-descending = abap_true
                                        THEN `DESCENDING`
                                        ELSE `ASCENDING` ).

      lv_orderby = COND string( WHEN lv_orderby IS INITIAL
                                THEN |{ lv_prefix }{ ls_sort-element_name } { lv_direction }|
                                ELSE |{ lv_orderby }, { lv_prefix }{ ls_sort-element_name } { lv_direction }| ).
    ENDLOOP.

    IF lv_orderby IS INITIAL.
      lv_orderby = `k~ebeln ASCENDING`.
    ENDIF.

    " ---- Paging ------------------------------------------------------------
    " This example never relies on "UP TO 0 ROWS means unlimited". If the
    " framework supplies a non-positive page size, the example falls back to
    " C_MAX_PAGE_SIZE so the result set stays bounded. A productive
    " implementation either always receives a positive page size from the
    " consumer or handles the unlimited case explicitly.
    DATA(lo_paging) = io_request->get_paging( ).
    DATA(lv_offset) = lo_paging->get_offset( ).
    DATA(lv_top)    = COND i( WHEN lo_paging->get_page_size( ) > 0
                              THEN lo_paging->get_page_size( )
                              ELSE c_max_page_size ).

    SELECT k~ebeln, p~ebelp, t~etenr, k~bedat, k~bsart, k~aedat, k~lifnr,
           k~zterm, p~matnr, p~txz01, p~werks, p~lgort, p~menge, p~peinh,
           t~eindt, t~menge AS emenge, p~meins, p~netpr, p~netwr, k~waers,
           p~bukrs, p~elikz
      FROM ekko AS k
      INNER JOIN ekpo AS p ON k~ebeln = p~ebeln
      LEFT OUTER JOIN eket AS t ON  p~ebeln = t~ebeln
                               AND  p~ebelp = t~ebelp
      WHERE k~bstyp  = 'F'
        AND p~loekz  = @abap_false
        AND k~ebeln IN @lr_ebeln
        AND k~bsart IN @lr_bsart
        AND k~aedat IN @lr_aedat
        AND k~ernam IN @lr_ernam
        AND k~ekorg IN @lr_ekorg
        AND p~matnr IN @lr_matnr
        AND p~werks IN @lr_werks
        AND p~bukrs IN @lr_bukrs
      ORDER BY (lv_orderby)
      INTO TABLE @DATA(lt_data)
      UP TO @lv_top ROWS OFFSET @lv_offset.

    IF lt_data IS INITIAL.
      RETURN.
    ENDIF.

    " ---- Enrichment --------------------------------------------------------
    SELECT zterm, ztag1
      FROM t052
      FOR ALL ENTRIES IN @lt_data
      WHERE zterm = @lt_data-zterm
      INTO TABLE @DATA(lt_t052).

    SELECT bsart, batxt
      FROM t161t
      FOR ALL ENTRIES IN @lt_data
      WHERE spras = @sy-langu
        AND bstyp = 'F'
        AND bsart = @lt_data-bsart
      INTO TABLE @DATA(lt_t161t).

    SELECT ebeln, ebelp, budat
      FROM matdoc
      FOR ALL ENTRIES IN @lt_data
      WHERE ebeln     = @lt_data-ebeln
        AND ebelp     = @lt_data-ebelp
        AND cancelled = @abap_false
      INTO TABLE @DATA(lt_matdoc).

    LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<fs_data>).
      <fs_data>-emeins = <fs_data>-meins.
      <fs_data>-ewaers = <fs_data>-waers.

      <fs_data>-batxt  = VALUE #( lt_t161t[ bsart = <fs_data>-bsart ]-batxt OPTIONAL ).
      <fs_data>-ztag1  = VALUE #( lt_t052[ zterm = <fs_data>-zterm ]-ztag1 OPTIONAL ).
      <fs_data>-eindt  = VALUE #( lt_matdoc[ ebeln = <fs_data>-ebeln
                                             ebelp = <fs_data>-ebelp ]-budat OPTIONAL ).

      <fs_data>-neindt = <fs_data>-eindt + <fs_data>-ztag1.

      " Value of the delivered quantity, guarding the price-unit divisor.
      DATA(lv_peinh) = COND #( WHEN <fs_data>-peinh <> 0 THEN <fs_data>-peinh ELSE 1 ).
      <fs_data>-enetwr = <fs_data>-emenge / lv_peinh * <fs_data>-netpr.

      " ---- Optional reporting-currency conversion --------------------------
      " The target currency is supplied by the caller (e.g. read from
      " T001-WAERS for the company code). No currency is hard-coded here.
      IF iv_local_currency IS INITIAL.
        CONTINUE.
      ENDIF.

      <fs_data>-waers_loc = iv_local_currency.

      IF <fs_data>-waers = iv_local_currency.
        <fs_data>-netpr_loc  = <fs_data>-netpr.
        <fs_data>-netwr_loc  = <fs_data>-netwr.
        <fs_data>-enetwr_loc = <fs_data>-enetwr.
        CONTINUE.
      ENDIF.

      CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
          date             = <fs_data>-bedat
          foreign_amount   = <fs_data>-netpr
          foreign_currency = <fs_data>-waers
          local_currency   = iv_local_currency
        IMPORTING
          local_amount     = <fs_data>-netpr_loc
        EXCEPTIONS
          no_rate_found    = 1
          overflow         = 2
          no_factors_found = 3
          no_spread_found  = 4
          derived_2_times  = 5
          OTHERS           = 6.

      IF sy-subrc <> 0.
        " No usable rate on the document date: leave the converted amounts
        " initial rather than reporting a wrong value.
        CLEAR: <fs_data>-netpr_loc, <fs_data>-netwr_loc, <fs_data>-enetwr_loc.
        CONTINUE.
      ENDIF.

      <fs_data>-netwr_loc  = <fs_data>-menge  * <fs_data>-netpr_loc.
      <fs_data>-enetwr_loc = <fs_data>-emenge * <fs_data>-netpr_loc.
    ENDLOOP.

    et_data = lt_data.
  ENDMETHOD.


  METHOD _get_goods_movement.
    DATA: lr_ebeln TYPE RANGE OF ebeln,
          lr_ebelp TYPE RANGE OF ebelp.

    CLEAR et_data.

    LOOP AT io_filter->get_as_ranges( ) INTO DATA(ls_filter).
      CASE ls_filter-name.
        WHEN 'EBELN'. lr_ebeln = CORRESPONDING #( ls_filter-range ).
        WHEN 'EBELP'. lr_ebelp = CORRESPONDING #( ls_filter-range ).
      ENDCASE.
    ENDLOOP.

    " A goods-movement read without a document restriction would scan the
    " whole material document table - require the PO number from the request.
    IF lr_ebeln IS INITIAL.
      RETURN.
    ENDIF.

    SELECT matdoc~ebeln,
           matdoc~ebelp,
           matdoc~budat,
           matdoc~bwart,
           t156t~btext_l,
           matdoc~stock_qty,
           matdoc~meins,
           matdoc~mblnr,
           matdoc~mjahr,
           matdoc~zeile
      FROM matdoc
      INNER JOIN t156t ON  t156t~bwart = matdoc~bwart
                      AND  t156t~sobkz = matdoc~sobkz
                      AND  t156t~kzbew = matdoc~kzbew
                      AND  t156t~kzzug = matdoc~kzzug
                      AND  t156t~kzvbr = matdoc~kzvbr
                      AND  t156t~spras = @sy-langu
      WHERE matdoc~ebeln     IN @lr_ebeln
        AND matdoc~ebelp     IN @lr_ebelp
        AND matdoc~cancelled  = @abap_false
      INTO CORRESPONDING FIELDS OF TABLE @et_data.
  ENDMETHOD.

ENDCLASS.
