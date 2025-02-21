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
