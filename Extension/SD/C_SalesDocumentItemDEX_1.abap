@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SDI'

@EndUserText.label: 'C_SalesDocumentItemDEX_1 Extend View'

extend view C_SalesDocumentItemDEX_1 with ZSM_I_EXT_SDI

{
  SalesDocument.PriceListType,
  SalesDocumentItem.ValuationType
}
