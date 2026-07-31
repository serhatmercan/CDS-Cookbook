" ============================================================================
" Type        : ZSM_I_VALUATION_TYPE_VH  (root view entity, value help)
" Module      : MM
" Business Object : Material Valuation Type
" ----------------------------------------------------------------------------
" Description
"   Value help listing material/valuation-area/valuation-type combinations
"   from MBEW. The file also keeps a second snippet below the view entity
"   ("Using in CDS") showing how a consuming CDS field declares
"   @Consumption.valueHelpDefinition against this view's Bwtar element,
"   with Bwkey bound via an additionalBinding to a Plant selection field.
"
" Associations Used   (none)
"
" Common Use Cases
"   - F4 value help for a "ValuationType" field, plant-dependent via
"     additionalBinding to I_PlantStdVH
"
" Notes
"   - The trailing snippet is a usage example, not part of this view entity
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Valuation Type Value Help'

@Search.searchable: true

define root view entity ZSM_I_VALUATION_TYPE_VH
  as select from mbew

{
      @Search.defaultSearchElement: true
  key matnr as Matnr,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } } ]
      @Search.defaultSearchElement: true
  key bwkey as Bwkey,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key bwtar as Bwtar
}

" Using in CDS
@UI:

{
  identification  :[{ position: 60 }],
  lineItem        :[{ position: 60, importance: #HIGH }],
  selectionField  :[{ position: 70 }]
}

@Consumption.valueHelpDefinition: [ { additionalBinding: [ { element: 'Bwkey', localElement: 'Plant' } ],
                                      distinctValues: true,
                                      entity: { name: 'ZSM_I_VALUATION_TYPE_VH', element: 'Bwtar' } } ]

@Search.defaultSearchElement: true
key ValuationType
