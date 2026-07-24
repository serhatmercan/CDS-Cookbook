@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_BDEIB'

@EndUserText.label: 'I_BillingDocExtdItemBasic Extend View'

extend view I_BillingDocExtdItemBasic with ZSM_I_EXT_BDEIB

{
  _SalesDocument.RequestedDeliveryDate,
  _SalesDocument.ShippingType,
  vbrp.bwtar                            as ValuationType,
  vbrp.stadat                           as StatisticDate
}
