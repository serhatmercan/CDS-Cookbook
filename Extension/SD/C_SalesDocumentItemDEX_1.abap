" ============================================================================
" Extension   : C_SalesDocumentItemDEX_1  (extend view ... with ZSM_I_EXT_SDI)
" Module      : SD
" Business Object : Sales Document Item (Data Extraction)
" ----------------------------------------------------------------------------
" Description
"   Adds price list type (header) and valuation type (item) to the Sales
"   Document Item extraction view.
"
" Fields Added
"   PriceListType - SalesDocument.PriceListType
"   ValuationType - SalesDocumentItem.ValuationType
"
" Common Use Cases
"   - Sales document data extraction / reporting (CDS extraction for BW/analytics)
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SDI'

@EndUserText.label: 'C_SalesDocumentItemDEX_1 Extend View'

extend view C_SalesDocumentItemDEX_1 with ZSM_I_EXT_SDI

{
  SalesDocument.PriceListType,
  SalesDocumentItem.ValuationType
}
