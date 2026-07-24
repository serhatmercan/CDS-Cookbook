@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Vehicle No - Value Help'

@Search.searchable: true

define root view entity ZSD_I_VHC_NO
  as select from    oigv

    left outer join oigvt
      on  oigvt.vehicle  = oigv.vehicle
      and oigvt.language = $session.system_language

{
      @ObjectModel.text.element: [ 'veh_text' ]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key oigv.vehicle,

      @Search.defaultSearchElement: true
      oigvt.veh_text
}
