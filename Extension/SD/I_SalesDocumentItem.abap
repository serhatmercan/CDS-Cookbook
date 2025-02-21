@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SDI'
@EndUserText.label: 'I_SalesDocumentItem Extend View'

extend view I_SalesDocumentItem with ZSM_I_EXT_SDI
{
    vbap.bwtar as ValuationType
}