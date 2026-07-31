" ============================================================================
" Extension   : C_TimeVarianceQuery  (extend view ... with ZSM_I_EXT_TVQ)
" Module      : MM
" Business Object : Purchasing Time Variance (Analytics Query)
" ----------------------------------------------------------------------------
" Description
"   Adds Product External ID as a local analytics dimension (rows axis,
"   displayed by key) to the Time Variance analytical query.
"
" Fields Added
"   ZZProductExternalID - C_TimeVarianceCube._Material.ProductExternalID, local analytics element
"
" Associations Used
"   _Material (existing, from C_TimeVarianceCube) -> Product master
"
" Common Use Cases
"   - Analytical query / OData analytics: break down time variance by product
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_TVQ'

@EndUserText.label: 'C_TimeVarianceQuery Extend View'

extend view C_TimeVarianceQuery with ZSM_I_EXT_TVQ

{
  @AnalyticsDetails.internalName: #LOCAL
  @AnalyticsDetails.query: { axis: #ROWS, display: #KEY }
  @EndUserText.label: 'Test III'
  C_TimeVarianceCube._Material.ProductExternalID as ZZProductExternalID
}
