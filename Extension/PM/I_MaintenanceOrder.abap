" ============================================================================
" Extension   : I_MaintenanceOrder  (extend view ... with ZSM_I_EXT_MO)
" Module      : PM
" Business Object : Maintenance Order
" ----------------------------------------------------------------------------
" Description
"   Empty extension include (placeholder) - registers the custom extension
"   ZSM_I_EXT_MO against I_MaintenanceOrder without adding any fields yet.
"
" Notes
"   - No fields currently added; kept as an extension slot for future use
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MO'
@EndUserText.label: 'I_MaintenanceOrder Extend View'

extend view I_MaintenanceOrder with ZSM_I_EXT_MO
{
   
}
