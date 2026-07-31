" ============================================================================
" Extension   : C_ObjPgMaintOrderAndOperation  (extend view ... with ZSM_I_EXT_OPMOO)
" Module      : PM
" Business Object : Maintenance Order Operation (Object Page)
" ----------------------------------------------------------------------------
" Description
"   Adds a virtual, read-calculated ProcessStatus field showing the system
"   status text (via STATUS_TEXT_EDIT) of each order operation, computed and
"   filterable through the SADL exit class ZSM_CL_MOO.
"
" Fields Added
"   ProcessStatus - virtual element, calculated by ABAP class ZSM_CL_MOO
"                   (reads POPORDOP for the operation's internal object number,
"                    then calls STATUS_TEXT_EDIT to render the status line)
"
" Common Use Cases
"   - Maintenance Order Object Page: show live system status text per operation
"   - Filtering the object page list by status text (filter.transformedBy)
"
" Notes
"   - Implements if_sadl_exit_calc_element_read (CALCULATE) and
"     if_sadl_exit_filter_transform (MAP_ATOM) for read + filter support
"   - Per-row RFC-like call to STATUS_TEXT_EDIT inside a loop; watch for
"     performance on large result sets
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_OPMOO'
@EndUserText.label: 'C_ObjPgMaintOrderAndOperation Extend View'

extend view C_ObjPgMaintOrderAndOperation with ZSM_I_EXT_OPMOO
{   
    @ObjectModel: {
        filter.transformedBy: 'ABAP:ZSM_CL_MOO',
        virtualElement: true,
        virtualElementCalculatedBy: 'ABAP:ZSM_CL_MOO'
       
    }
    @UI.lineItem: {
        fieldGroup: {
            importance: #HIGH,
            position: 200,
            qualifier: 'HeaderInfo3'            
        }, 
        importance: #HIGH,
        position: 200 
    }
    @Search.defaultSearchElement: true
    cast('' as SSTRING) as ProcessStatus
}

---

CLASS ZSM_CL_MOO DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

PUBLIC SECTION.

  INTERFACES if_sadl_exit.
  INTERFACES if_sadl_exit_calc_element_read.
  INTERFACES if_sadl_exit_filter_transform.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS ZSM_CL_MOO IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZSM_CL_MOO->IF_SADL_EXIT_CALC_ELEMENT_READ~CALCULATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_ORIGINAL_DATA               TYPE        STANDARD TABLE
* | [--->] IT_REQUESTED_CALC_ELEMENTS     TYPE        TT_ELEMENTS
* | [<-->] CT_CALCULATED_DATA             TYPE        STANDARD TABLE
* | [!CX!] CX_SADL_EXIT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lt_opmoo TYPE TABLE OF c_objpgmaintorderandoperation,
          lv_line  TYPE bsvx-sttxt,
          lv_objnr TYPE jest-objnr.

    lt_opmoo = CORRESPONDING #( it_original_data ).

    IF lt_opmoo IS INITIAL.
      RETURN.
    ENDIF.

    SELECT maintenanceorder, maintenanceorderoperation, maintenanceordersuboperation, maintorderoperationinternalid
      FROM popordop
      FOR ALL ENTRIES IN @lt_opmoo
      WHERE maintenanceorder                EQ @lt_opmoo-maintenanceorder
        AND maintenanceorderoperation       EQ @lt_opmoo-maintenanceorderoperation
        AND maintenanceordersuboperation    EQ @lt_opmoo-maintenanceordersuboperation
      INTO TABLE @DATA(lt_table).

    SORT lt_table BY maintenanceorder maintenanceorderoperation maintenanceordersuboperation.

    LOOP AT lt_opmoo ASSIGNING FIELD-SYMBOL(<fs_opmoo>).
      READ TABLE lt_table INTO DATA(ls_table) WITH KEY maintenanceorder             = <fs_opmoo>-maintenanceorder
                                                       maintenanceorderoperation    = <fs_opmoo>-maintenanceorderoperation
                                                       maintenanceordersuboperation = <fs_opmoo>-maintenanceordersuboperation BINARY SEARCH.
      IF sy-subrc NE 0.
        CONTINUE.
      ENDIF.
        lv_objnr = ls_table-maintorderoperationinternalid.
        
        CLEAR: ls_table, lv_line.
        
        CALL FUNCTION 'STATUS_TEXT_EDIT'
            EXPORTING
            objnr            = lv_objnr
            only_active      = abap_true
            spras            = sy-langu
            bypass_buffer    = abap_true
            IMPORTING
            line             = lv_line
            EXCEPTIONS
            object_not_found = 1.

        <fs_opmoo>-processstatus = lv_line.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_opmoo ).
  ENDMETHOD.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZSM_CL_MOO->IF_SADL_EXIT_FILTER_TRANSFORM~MAP_ATOM
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_ENTITY                      TYPE        STRING
* | [--->] IV_ELEMENT                     TYPE        SADL_ENTITY_ELEMENT
* | [--->] IV_OPERATOR                    TYPE        STRING
* | [--->] IV_VALUE                       TYPE        STRING
* | [<-()] RO_CONDITION                   TYPE REF TO IF_SADL_COND_PROVIDER_GENERIC
* | [!CX!] CX_SADL_EXIT_FILTER_NOT_SUPP
* | [!CX!] CX_SADL_EXIT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD if_sadl_exit_filter_transform~map_atom.
    ro_condition = cl_sadl_cond_prov_factory_pub=>create_simple_cond_factory( )->element( 'PROCESSSTATUS' )->equals( iv_value ).
  ENDMETHOD.
ENDCLASS.
