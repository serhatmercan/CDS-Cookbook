" ============================================================================
" Extension   : I_BillingDocExtdItemBasic  (extend view ... with ZSM_I_EXT_BDEIB)
" Module      : SD
" Business Object : Billing Document Item (Extended Basic)
" ----------------------------------------------------------------------------
" Description
"   Adds requested delivery date and shipping type from the related Sales
"   Document, plus valuation type and statistics date read directly from the
"   underlying VBRP table.
"
" Fields Added
"   RequestedDeliveryDate - _SalesDocument.RequestedDeliveryDate
"   ShippingType          - _SalesDocument.ShippingType
"   ValuationType         - vbrp.bwtar
"   StatisticDate         - vbrp.stadat
"
" Associations Used
"   _SalesDocument (existing, standard)
"
" Common Use Cases
"   - Billing document item list/reporting: shipping/valuation context per item
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_BDEIB'

@EndUserText.label: 'I_BillingDocExtdItemBasic Extend View'

extend view I_BillingDocExtdItemBasic with ZSM_I_EXT_BDEIB

{
  _SalesDocument.RequestedDeliveryDate,
  _SalesDocument.ShippingType,
  vbrp.bwtar                            as ValuationType,
  vbrp.stadat                           as StatisticDate
}
