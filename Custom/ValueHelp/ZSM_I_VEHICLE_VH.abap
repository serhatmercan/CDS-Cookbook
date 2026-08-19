// ============================================================================
// Type       : complete CDS (view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_VEHICLE_VH  (root value help view)
// Module      : MM (IS-OIL)
// Business Object : Vehicle
// ----------------------------------------------------------------------------
// Description
//   Value help listing IS-OIL vehicle master records (OIGV) with vehicle
//   type and language-dependent vehicle text (OIGVT), searchable by vehicle
//   and vehicle type with high-ranking fuzzy search.
//
// Associations Used   (none - plain join in the FROM clause)
//
// Common Use Cases
//   - F4 value help for vehicle number fields (e.g. ZZ_VEHICLE_1 / ZZ_VEHICLE_2
//     in ZSD_I_ORDER)
//
// Related CDS
//   ZSD_I_ORDER
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Vehicle Value Help'

@Search.searchable: true

define root view entity ZSM_I_VEHICLE_VH
  as select from oigv

    inner join   oigvt
      on  oigvt.vehicle  = oigv.vehicle
      and oigvt.language = $session.system_language

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key oigv.vehicle   as Vehicle,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH

      oigv.veh_type  as VehicleType,

      oigvt.veh_text as VehicleText
}
