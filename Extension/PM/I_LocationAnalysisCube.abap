// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension   : I_LocationAnalysisCube  (extend view ... with ZSM_I_EXT_LAC)
// Module      : PM
// Business Object : Location Analysis (Analytical Cube)
// ----------------------------------------------------------------------------
// Description
//   Adds a broad set of Maintenance Notification attributes to the Location
//   Analysis cube, sourced from I_MaintNotificationTechObj, for notification
//   related analytics at the technical object/location level.
//
// Fields Added
//   IsCompleted, LastChangeTime, MaintenanceActivityType, MaintenanceItem,
//   MaintenancePlan, MaintNotifDowntimeDuration, MaintNotificationCatalog,
//   MaintNotificationCode, MaintNotificationCodeGroup,
//   MaintObjectLocAcctAssgmtNmbr, MaintenanceOrder, MaintenanceWorkCenterPlant,
//   NotificationReferenceTime, TechnicalObject, WorkCenterInternalID
//   (all via I_MaintNotificationTechObj)
//
// Common Use Cases
//   - Location/technical-object analytics: notification volume, downtime,
//     completion status by location
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_LAC'

@EndUserText.label: 'I_LocationAnalysisCube Extend View'

extend view I_LocationAnalysisCube with ZSM_I_EXT_LAC

{
  I_MaintNotificationTechObj.IsCompleted,
  I_MaintNotificationTechObj.LastChangeTime,
  I_MaintNotificationTechObj.MaintenanceActivityType,
  I_MaintNotificationTechObj.MaintenanceItem,
  I_MaintNotificationTechObj.MaintenancePlan,
  I_MaintNotificationTechObj.MaintNotifDowntimeDuration,
  I_MaintNotificationTechObj.MaintNotificationCatalog,
  I_MaintNotificationTechObj.MaintNotificationCode,
  I_MaintNotificationTechObj.MaintNotificationCodeGroup,
  I_MaintNotificationTechObj.MaintObjectLocAcctAssgmtNmbr,
  I_MaintNotificationTechObj.MaintenanceOrder,
  I_MaintNotificationTechObj.MaintenanceWorkCenterPlant,
  I_MaintNotificationTechObj.NotificationReferenceTime,
  I_MaintNotificationTechObj.TechnicalObject,
  I_MaintNotificationTechObj.WorkCenterInternalID
}
