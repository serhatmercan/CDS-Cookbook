" ============================================================================
" Extension   : C_Insplotmng  (extend view ... with ZSM_I_EXT_IM)
" Module      : QM
" Business Object : Inspection Lot Management
" ----------------------------------------------------------------------------
" Description
"   Passes through the Txt04 field (added by the underlying I_InspectionLot
"   extension) into the Inspection Lot Management view.
"
" Fields Added
"   Txt04 - status short text, propagated from the I_InspectionLot extension
"
" Common Use Cases
"   - Inspection lot management UI: show status text alongside lot data
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_IM'

@EndUserText.label: 'C_Insplotmng Extend View'

extend view C_Insplotmng with ZSM_I_EXT_IM

{
  Txt04
}
