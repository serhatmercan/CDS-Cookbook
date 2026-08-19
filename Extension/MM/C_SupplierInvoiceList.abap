// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension   : C_SupplierInvoiceList(extend view ... with ZSM_I_EXT_SIL)
// Module      : MM
// Business Object : Supplier Invoice
// ----------------------------------------------------------------------------
// Description
//   Exposes Business Area on the Supplier Invoice List with value help,
//   search, and selection - field enablement.
//
// Fields Added
//   BusinessArea(invoice.BusinessArea) - value help, searchable, selection field
//
// Associations Used
//   _CABAVH - > C_CABusinessAreaValueHelp   on BusinessArea = businessarea
//
// Common Use Cases
//   - Supplier Invoice List: filter/search by Business Area, F4 help
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_SIL'

@EndUserText.label: 'C_SupplierInvoiceList Extend View'

extend view C_SupplierInvoiceList with ZSM_I_EXT_SIL

  association [0..1] to C_CABusinessAreaValueHelp as _CABAVH on _CABAVH.BusinessArea = $projection.businessarea

{
  @Consumption.valueHelpDefinition: [ { entity: { name: 'C_CABusinessAreaValueHelp', element: 'BusinessArea' } } ]
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  @UI.lineItem: [ { importance: #HIGH, position: 110 } ]
  @UI.selectionField.position: 70
  invoice.BusinessArea
}
