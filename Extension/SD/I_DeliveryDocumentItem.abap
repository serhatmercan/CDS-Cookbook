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
