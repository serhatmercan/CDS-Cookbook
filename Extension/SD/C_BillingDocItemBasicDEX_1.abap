// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension   : C_BillingDocItemBasicDEX_1  (extend view ... with ZSM_I_EXT_BDIBD)
// Module      : SD
// Business Object : Billing Document Item (Data Extraction)
// ----------------------------------------------------------------------------
// Description
//   Adds delivery/pricing/valuation related fields to the Billing Document
//   Item extraction view, pulled from the item itself and its Product /
//   Sales Document Item associations.
//
// Fields Added
//   ProductHierarchyNode   - BillingDocumentItemBasic.ProductHierarchyNode
//   RequestedDeliveryDate  - BillingDocumentItemBasic.RequestedDeliveryDate
//   ShippingType           - BillingDocumentItemBasic.ShippingType
//   StatisticDate          - BillingDocumentItemBasic.StatisticDate
//   ValuationType          - BillingDocumentItemBasic.ValuationType
//   ProductCategory        - BillingDocumentItemBasic._Product.ProductCategory
//   SalesDocumentType      - BillingDocumentItemBasic._SalesDocumentItem.SalesDocumentType
//
// Common Use Cases
//   - Billing document data extraction / reporting (CDS extraction for BW/analytics)
// ============================================================================

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
