" ============================================================================
" Extension   : C_RSHMaintSchedSmltdOp  (extend view ... with ZSM_I_EXT_RSH_MSSO)
" Module      : PM
" Business Object : Maintenance Scheduling - Simulated Operation
" ----------------------------------------------------------------------------
" Description
"   Adds a virtual, read-only TextI field carrying a custom operation text
"   (AFVC-ZZ_TEXT_1), computed and filterable through the SADL exit class
"   ZSM_CL_RSH_MSSO.
"
" Fields Added
"   TextI - virtual element, calculated by ABAP class ZSM_CL_RSH_MSSO
"           (joins AFVC on maintorderroutingnumber/operation to read ZZ_TEXT_1)
"
" Common Use Cases
"   - Resource Scheduling (RSH) Gantt/board: show custom operation text
"
" Notes
"   - Implements if_sadl_exit_calc_element_read (CALCULATE) and
"     if_sadl_exit_filter_transform (MAP_ATOM); filter only applies when
"     entity is C_RSHMAINTOPERATIONASSIGNMENT
"   - Field is @ObjectModel.readOnly: true
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_RSH_MSSO'
@EndUserText.label: 'C_RSHMaintSchedSmltdOp Extend View'

extend view C_RSHMaintSchedSmltdOp with ZSM_I_EXT_RSH_MSSO
{
    @ObjectModel: {
        filter.transformedBy: 'ABAP:ZSM_CL_RSH_MSSO',
        readOnly: true,
        virtualElement: true,
        virtualElementCalculatedBy: 'ABAP:ZSM_CL_RSH_MSSO',
    }
    cast('' as zsm_e_textI) as TextI
}

---

CLASS ZSM_CL_RSH_MSSO DEFINITION
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

CLASS ZSM_CL_RSH_MSSO IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZSM_CL_RSH_MSSO->IF_SADL_EXIT_CALC_ELEMENT_READ~CALCULATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IT_ORIGINAL_DATA               TYPE        STANDARD TABLE
* | [--->] IT_REQUESTED_CALC_ELEMENTS     TYPE        TT_ELEMENTS
* | [<-->] CT_CALCULATED_DATA             TYPE        STANDARD TABLE
* | [!CX!] CX_SADL_EXIT
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_rsh_msso TYPE TABLE OF c_rshmaintschedsmltdop.
  
    lt_rsh_msso = CORRESPONDING #( it_original_data ).

    IF lt_rsh_msso IS INITIAL.
      RETURN.
    ENDIF.
  
    SELECT t1~aufpl, t1~vornr, t1~zz_text_1       
      FROM afvc AS t1
      INNER JOIN c_rshmaintschedsmltdop AS t2
        ON t2~maintorderroutingnumber EQ t1~aufpl
      INTO TABLE @DATA(lt_table).
  
    LOOP AT lt_rsh_msso ASSIGNING FIELD-SYMBOL(<fs_rsh_msso>).
        <fs_rsh_msso>-text1 = VALUE #( lt_table[ aufpl = <fs_rsh_msso>-maintorderroutingnumber
                                                 vornr = <fs_rsh_msso>-maintenanceorderoperation ]-zz_text_1 OPTIONAL ).
    ENDLOOP.
  
    ct_calculated_data = CORRESPONDING #( lt_rsh_msso ).
  ENDMETHOD.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZSM_CL_RSH_MSSO->IF_SADL_EXIT_FILTER_TRANSFORM~MAP_ATOM
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
    IF iv_element = 'TEXT1' AND iv_entity = 'C_RSHMAINTOPERATIONASSIGNMENT'.
        ro_condition = cl_sadl_cond_prov_factory_pub=>create_simple_cond_factory( )->element( 'TEXT1' )->equals( iv_value ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.