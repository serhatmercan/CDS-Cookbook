" ============================================================================
" Extension   : C_MaintNotificationTP  (extend view ... with ZSM_I_EXT_MN_TP)
" Module      : PM
" Business Object : Maintenance Notification (Transactional Projection)
" ----------------------------------------------------------------------------
" Description
"   Adds Maintenance Activity Type to the Maintenance Notification
"   transactional projection view.
"
" Fields Added
"   MaintenanceActivityType - _MaintNotificationTP.MaintenanceActivityType
"
" Common Use Cases
"   - Maintenance Notification app: display/filter by activity type
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MN_TP'

@EndUserText.label: 'C_MaintNotificationTP Extend View'

extend view C_MaintNotificationTP with ZSM_I_EXT_MN_TP

{
  _MaintNotificationTP.MaintenanceActivityType
}
