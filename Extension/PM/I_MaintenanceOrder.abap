// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension  : I_MaintenanceOrder  (extend view ... with ZSM_I_EXT_MO)
// Module     : PM
// Business Object : Maintenance Order
// ----------------------------------------------------------------------------
// Description
//   Adds order master attributes to the Maintenance Order interface view by
//   navigating existing standard associations, so consumers of
//   I_MaintenanceOrder see them without extra joins of their own.
//
// Fields Added
//   MaintenanceOrderType  - _MaintenanceOrderType.MaintenanceOrderType
//   Plant                 - _MaintenancePlanningPlant.Plant
//
// Associations Used
//   _MaintenanceOrderType, _MaintenancePlanningPlant (existing, standard)
//
// Patterns demonstrated
//   - reaching fields through the extended view's own associations, which
//     needs no new association in the append
//
// Note
//   An earlier revision left this file as an empty extension body
//   ("{ }") described as a slot for future use. An empty append cannot be
//   activated, so it taught nothing; the empty-shell form now lives in
//   Extension/Template.abap where a placeholder belongs.
//
// Adaptation note
//   Verify the association names against I_MaintenanceOrder in your release
//   before copying - the association set of standard interface views changes
//   between releases.
//
// Common Use Cases
//   - Maintenance order reporting: order type / planning plant without extra joins
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MO'

@EndUserText.label: 'I_MaintenanceOrder Extend View'

extend view I_MaintenanceOrder with ZSM_I_EXT_MO

{
  _MaintenanceOrderType.MaintenanceOrderType,
  _MaintenancePlanningPlant.Plant
}
