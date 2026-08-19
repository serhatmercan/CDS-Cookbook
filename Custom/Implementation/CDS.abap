// ============================================================================
// Type       : complete CDS (root custom entity)
// Context    : reusable pattern
// CDS        : ZSM_C_PO
// Module     : MM
// Business Object : Purchase Order (query-provider backed)
// ----------------------------------------------------------------------------
// Description
//   Custom entity (no database source) exposing purchase order header/item
//   data. There is no SELECT: the runtime delegates data retrieval entirely
//   to the ABAP class named in @ObjectModel.query.implementedBy.
//
//   Use this when the result set cannot be expressed in SQL/CDS - function
//   module calls, external reads, or procedural enrichment.
//
// Patterns demonstrated
//   - define root custom entity + @ObjectModel.query.implementedBy
//   - element list typed directly from DDIC data elements
//   - composition to a child entity (the child declares the matching
//     association to parent - it is not declared on the root)
//   - @Consumption.valueHelpDefinition in its correct record form
//   - @UI selection/line-item/identification annotations on a custom entity
//
// Structure note
//   ZSM_C_PO is the ROOT. A root entity must not declare an association to
//   parent, and must not point one at itself. The child entity
//   ZSM_C_PO_ITEM (not part of this repository) carries
//   "association to parent ZSM_C_PO".
//
// Paired with
//   Custom/Implementation/Class.abap - the IF_RAP_QUERY_PROVIDER
//   implementation recipes for entities of this kind.
// ============================================================================

@EndUserText.label: 'Custom CDS Entity'

@ObjectModel.query.implementedBy: 'ABAP:ZSM_CL_IM_QUERY'

define root custom entity ZSM_C_PO
{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } } ]
      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { cssDefault.width: '10em', position: 10, importance: #HIGH } ]
      @UI.selectionField: [ { position: 10 } ]
  key CompanyCode           : bukrs;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSM_I_BSART', element: 'Bsart' } } ]
      @ObjectModel.text.element: [ 'PurchaseOrderTypeName' ]
      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 20 } ]
      @UI.lineItem: [ { position: 20, importance: #HIGH } ]
      @UI.selectionField: [ { position: 20 } ]
  key PurchaseOrderType     : bsart;

      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 30 } ]
      @UI.lineItem: [ { position: 30, importance: #HIGH } ]
      @UI.selectionField: [ { position: 30 } ]
  key PurchaseOrder         : vdmpurchaseorder;

      @UI.identification: [ { position: 190 } ]
      @UI.lineItem: [ { position: 190, importance: #HIGH } ]
  key PurchaseOrderItem     : vdmpurchaseorderitem;

      // Text element for the order type, filled by the query provider.
      // An element must never be declared as its own text element.
      @UI.identification: [ { position: 40 } ]
      @UI.lineItem: [ { position: 40, importance: #MEDIUM } ]
      PurchaseOrderTypeName : abap.char(20);

      @Consumption.filter.hidden: true
      @UI.identification: [ { position: 620 } ]
      @UI.lineItem: [ { position: 620, importance: #HIGH } ]
      FirstDate             : datum;

      // The child entity declares the matching "association to parent".
      _Item                 : composition [0..*] of ZSM_C_PO_ITEM;
}
