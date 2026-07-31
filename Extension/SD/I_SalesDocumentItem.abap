" ============================================================================
" Extension   : I_SalesDocumentItem  (extend view ... with ZSM_I_EXT_SDI)
" Module      : SD
" Business Object : Sales Document Item
" ----------------------------------------------------------------------------
" Description
"   Adds Valuation Type to the Sales Document Item view, read directly from
"   the underlying VBAP table.
"
" Fields Added
"   ValuationType - vbap.bwtar
"
" Common Use Cases
"   - Sales order item list/reporting: batch/valuation-managed material context
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SDI'

@EndUserText.label: 'I_SalesDocumentItem Extend View'

extend view I_SalesDocumentItem with ZSM_I_EXT_SDI

{
  vbap.bwtar as ValuationType
}
