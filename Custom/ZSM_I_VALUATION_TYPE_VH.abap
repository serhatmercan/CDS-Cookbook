@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Valuation Type Value Help'
@Search.searchable: true

define root view entity ZSM_I_VALUATION_TYPE_VH 
  as select from mbew
{
  @Search.defaultSearchElement: true
  key matnr as Matnr,

  @Search.defaultSearchElement: true
  @Consumption.valueHelpDefinition: [{ 
    entity: {
        name: 'I_PlantStdVH',
        element: 'Plant'
      } 
  }]    
  key bwkey as Bwkey,

  @Search:{
    defaultSearchElement: true,
    fuzzinessThreshold: 0.8,
    ranking: #HIGH
  }
  key bwtar as Bwtar
}

" Using in CDS
@UI: {
    identification  : [{ position: 60 }],
    lineItem        : [{ position: 60, importance: #HIGH }],
    selectionField  : [{ position: 70 }] 
}
@Search.defaultSearchElement: true
@Consumption.valueHelpDefinition: [{ 
    additionalBinding: [{ 
        element: 'Bwkey', 
        localElement: 'Plant' 
    }],
    distinctValues: true,
    entity: { 
        name: 'ZSM_I_VALUATION_TYPE_VH',
        element: 'Bwtar' 
    }
}]
key ValuationType
