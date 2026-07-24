@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_BDIBD'

@EndUserText.label: 'C_BillingDocItemBasicDEX_1 Extend View'

extend view C_BillingDocItemBasicDEX_1 with ZSM_I_EXT_BDIBD

{
  BillingDocumentItemBasic.ProductHierarchyNode,
  BillingDocumentItemBasic.RequestedDeliveryDate,
  BillingDocumentItemBasic.ShippingType,
  BillingDocumentItemBasic.StatisticDate,
  BillingDocumentItemBasic.ValuationType,

  BillingDocumentItemBasic._Product.ProductCategory,
  BillingDocumentItemBasic._SalesDocumentItem.SalesDocumentType
}
