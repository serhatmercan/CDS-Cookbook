// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension   : R_MaintenanceItemTP  (extend view ... with ZSM_I_EXT_MI_TP)
// Module      : PM
// Business Object : Maintenance Item (Transactional Projection)
// ----------------------------------------------------------------------------
// Description
//   Adds a custom Z field to the Maintenance Item transactional projection
//   view, sourced from I_MaintenanceItem.
//
// Fields Added
//   ZZVALUE - I_MaintenanceItem.ZZVALUE
//
// Common Use Cases
//   - Maintenance Item app: expose custom attribute alongside standard fields
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MI_TP'

@EndUserText.label: 'R_MaintenanceItemTP Extend View'

extend view R_MaintenanceItemTP with ZSM_I_EXT_MI_TP

{
  I_MaintenanceItem.ZZVALUE
}

// Release note: R_* views are restricted-use RAP interface views. Verify the
// release/extensibility status of the target in your system before relying on it.
// Type: reference snippet / extension
// Context: SAP standard reference
