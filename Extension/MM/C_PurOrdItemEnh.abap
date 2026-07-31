" ============================================================================
" Extension   : C_PurOrdItemEnh  (extend view ... with ZMM_I_EXT_CPOITM)
" Module      : MM
" Business Object : Purchase Order Item
" ----------------------------------------------------------------------------
" Description
"   Adds the originating Request for Quotation (RFQ) number to the standard
"   Purchase Order Item view, sourced from a custom Z-table.
"
" Fields Added
"   zmm_rfq_h   - RequestForQuotation (via _v24)
"
" Associations Used
"   _v24 -> zmm_cds_0024   on ebeln = Purchaseorder, ebelp = PurchaseOrderItem
"
" Common Use Cases
"   - Purchase order item list / OVP: show which RFQ a PO item originated from
"
" Notes
"   - Exposed via UI.lineItem (semantic object ZMM_SO_0001) for Fiori list use
"
" Related CDS
"   I_PurchaseOrderItem, I_SupplierQuotation, C_TimeVarianceQuery
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_CPOITM'

@EndUserText.label: 'C_PurOrdItemEnh Extend View'

extend view C_PurOrdItemEnh with ZMM_I_EXT_CPOITM

  association [0..1] to zmm_cds_0024 as _v24
    on  _v24.ebeln = $projection.Purchaseorder
    and _v24.ebelp = $projection.PurchaseOrderItem

{
  @Consumption.semanticObject: 'ZMM_SO_0001'
  @UI.fieldGroup: [ { qualifier: 'ItemDetails', position: 14 } ]
  @UI.lineItem: [ { qualifier: 'PurchItem', position: 109, importance: #HIGH } ]

  _v24.RequestForQuotation as zmm_rfq_h
}
