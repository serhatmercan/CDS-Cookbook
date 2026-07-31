" ============================================================================
" Extension   : I_DeliveryDocumentItem  (extend view ... with ZSM_I_EXT_DDI)
" Module      : SD
" Business Object : Delivery Document Item
" ----------------------------------------------------------------------------
" Description
"   Adds a broad set of delivery, sales-reference and org-unit fields to the
"   Delivery Document Item view, sourced from LIPS directly and from the
"   Delivery Document, Controlling Area, Profit Center, Intercompany
"   Reference SD Document, Reference SD Document and Reference Sales
"   Document Item associations.
"
" Fields Added
"   ValuationType            - lips.bwtar
"   FiscalYearVariant         - _ControllingArea.FiscalYearVariant
"   ActualGoodsMovementDate, DeliveryBlockReason, DeliveryDate,
"   DeliveryDocumentType, LoadingPoint, PlannedGoodsIssueDate,
"   ProposedDeliveryRoute, ShippingPoint, ShippingType, Supplier
"                              - all from _DeliveryDocument
"   PriceListTypeRef           - _IntcoRefSDDocument.PriceListType
"   CompanyCode                - _ProfitCenter.CompanyCode
"   BillToParty, CustomerGroup, IncotermsClassification,
"   IncotermsTransferLocation, PayerParty, RequestedDeliveryDate,
"   SalesDistrict, SalesDocumentType, SalesEmployee, SalesOrganization,
"   ShipToParty, SoldToParty  - all from _ReferenceSalesDocumentItem
"   PriceListType              - _ReferenceSDDocument.PriceListType
"   WBSElement                 - _WBSElementBasicData.WBSElement
"
" Associations Used
"   _ControllingArea, _DeliveryDocument, _IntcoRefSDDocument, _ProfitCenter,
"   _ReferenceSalesDocumentItem, _ReferenceSDDocument, _WBSElementBasicData
"   (all existing, standard)
"
" Common Use Cases
"   - Delivery item list/reporting: sales/pricing/logistics context in one place
"     without extra app-level navigation
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_DDI'

@EndUserText.label: 'I_DeliveryDocumentItem Extend View'

extend view I_DeliveryDocumentItem with ZSM_I_EXT_DDI

{
  lips.bwtar                                             as ValuationType,

  _ControllingArea.FiscalYearVariant,

  _DeliveryDocument.ActualGoodsMovementDate,
  _DeliveryDocument.DeliveryBlockReason,
  _DeliveryDocument.DeliveryDate,
  _DeliveryDocument.DeliveryDocumentType,
  _DeliveryDocument.LoadingPoint,
  _DeliveryDocument.PlannedGoodsIssueDate,
  _DeliveryDocument.ProposedDeliveryRoute,
  _DeliveryDocument.ShippingPoint,
  _DeliveryDocument.ShippingType,
  _DeliveryDocument.Supplier,

  _IntcoRefSDDocument.PriceListType                      as PriceListTypeRef,

  _ProfitCenter.CompanyCode,

  _ReferenceSalesDocumentItem.BillToParty,
  _ReferenceSalesDocumentItem.CustomerGroup,
  _ReferenceSalesDocumentItem.IncotermsClassification,
  _ReferenceSalesDocumentItem.IncotermsTransferLocation,
  _ReferenceSalesDocumentItem.PayerParty,
  _ReferenceSalesDocumentItem.RequestedDeliveryDate,
  _ReferenceSalesDocumentItem.SalesDistrict,
  _ReferenceSalesDocumentItem.SalesDocumentType,
  _ReferenceSalesDocumentItem.SalesEmployee,
  _ReferenceSalesDocumentItem.SalesOrganization,
  _ReferenceSalesDocumentItem.ShipToParty,
  _ReferenceSalesDocumentItem.SoldToParty,

  _ReferenceSDDocument.PriceListType,

  _WBSElementBasicData.WBSElement
}
