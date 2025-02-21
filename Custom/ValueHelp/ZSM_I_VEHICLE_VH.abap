@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vehicle Value Help'
@Search.searchable: true

define root view entity ZSM_I_VEHICLE_VH
  as select from oigv
      inner join oigvt on oigvt.vehicle  = oigv.vehicle
                      and oigvt.language = $session.system_language
{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    key oigv.vehicle    as Vehicle,

    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    
    oigv.veh_type       as VehicleType,
    oigvt.veh_text      as VehicleText
}
