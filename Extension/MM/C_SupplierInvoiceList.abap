@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SIL'
@EndUserText.label: 'C_SupplierInvoiceList Extend View'

extend view C_SupplierInvoiceList with ZSM_I_EXT_SIL
    association [0..1] to C_CABusinessAreaValueHelp as _CABAVH on as .BusinessArea = $projection.businessarea 
{
  @Search: {
    defaultSearchElement: true,
    fuzzinessThreshold: 0.8,
    ranking: #HIGH
  }
  @UI: {
    lineItem: {
        importance: #HIGH,
        position: 110
    },
    selectionField.position: 70 
  }
  @Consumption.valueHelpDefinition: [{ 
    entity: { 
        name: 'C_CABusinessAreaValueHelp', 
        element: 'BusinessArea' 
    }
  }]
  invoice.BusinessArea 
}
