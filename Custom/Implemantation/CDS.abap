" ============================================================================
" Type        : ZSM_C_PO  (root custom entity, query implemented by ABAP class)
" Module      : MM
" Business Object : Purchase Order
" ----------------------------------------------------------------------------
" Description
"   Custom RAP entity (no DB source) exposing purchase order header data
"   (company code, doc type, PO number/item, first timestamp). Data retrieval
"   is delegated entirely to ZSM_CL_IM_QUERY via ObjectModel.query.implementedBy.
"
" Associations Used
"   _Header -> ZSM_C_PO (parent)        on EBELN = EBELN and EBELP = EBELP
"   _Item   -> ZSM_C_PO_ITEM            composition [0..*]
"
" Common Use Cases
"   - Custom RAP query entity for freeform SELECT logic not expressible in
"     plain CDS (FM calls, non-buffered joins, computed deadlines)
"
" Notes
"   - Paired with Custom/Implemantation/Class.abap, which implements the query
"     logic for this entity (ZSM_CL_IM_QUERY, entity id 'ZSM_C_PO').
" ============================================================================

@EndUserText.label: 'Custom CDS Entity'

@ObjectModel.query.implementedBy: 'ABAP:ZSM_CL_IM_QUERY'

define root custom entity ZSM_C_PO

{
      @Consumption.valueHelpDefinition: [ { entity.element: 'CompanyCode', name: 'I_COMPANYCODESTDVH' } ]
      @ObjectModel.text.element: [ 'CompanyCode' ]
      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { cssDefault.width: '10em', position: 10, importance: #HIGH } ]
      @UI.selectionField: [ { position: 10 } ]
  key COMPANYCODE                 : Bukrs;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSM_I_BSART', element: 'Bsart' } } ]
      @ObjectModel.text.element: [ 'Batxt' ]
      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 20 } ]
      @UI.lineItem: [ { position: 20, importance: #HIGH } ]
      @UI.selectionField: [ { position: 20 } ]
      PURCHASEORDERTYPE               : Bsart;

      @Search.defaultSearchElement: true
      @UI.identification: [ { position: 30 } ]
      @UI.lineItem: [ { position: 30, importance: #HIGH } ]
      @UI.selectionField: [ { position: 30 } ]
      PURCHASEORDER                   : VDMPurchaseOrder;

      @UI.identification: [ { position: 190 } ]
      @UI.lineItem: [ { position: 190, importance: #HIGH } ]
      PURCHASEORDERITEM               : VDMPurchaseOrderItem;

      @Consumption.filter.hidden: true
      @UI.identification: [ { position: 620 } ]
      @UI.lineItem: [ { position: 620, importance: #HIGH } ]
      FIRSTTIMESTAMP                  : Datum;


      _Header                         : association to parent ZSM_C_PO on  _Header.EBELN = $projection.EBELN
                                                                       and _Header.EBELP = $projection.EBELP;

      _Item                           : composition [0..*] of ZSM_C_PO_ITEM;
}
