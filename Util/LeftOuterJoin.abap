// ============================================================================
// View        : ZSM_I_VEHICLE_ENRICHED  (root view entity with multiple LEFT OUTER JOINs)
// Module      : SD
// Business Object : Vehicle
// ----------------------------------------------------------------------------
// Description
//   Reusable pattern for a root view combining a header table with text,
//   custom, and document tables via LEFT OUTER JOIN.
//
// Common Use Cases
//   - Enriching a key entity (vehicle) with description text, custom master data, and a related billing document without excluding rows that lack a match
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Vehicle Information'

define root view entity ZSM_I_VEHICLE_ENRICHED
  as select from    oigv

    left outer join oigvt
      on  oigvt.vehicle  = oigv.vehicle
      and oigvt.language = $session.system_language

    left outer join zsm_i_max_validity as i0001
      on i0001.plate = oigv.vehicle

    left outer join vbrk
      on  vbrk.vbeln  = oigv.vehicle
      and vbrk.fksto != 'X'

{
  key oigv.vehicle,

      oigvt.veh_text,
      i0001.begda,
      i0001.endda
}

// Type    : complete CDS (view entity)
// Context : reusable pattern
