@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MOC'
@EndUserText.label: 'I_MaintenanceOrderConfirmation Extend View'

extend view I_MaintenanceOrderConfirmation with ZSM_I_EXT_MOC
{
    _ActualWorkCenter.WorkCenter,

    _MaintenanceOrder.MaintenanceActivityType,
    _MaintenanceOrder.MaintPriority,
    _MaintenanceOrder.MainWorkCenter,

    _MaintenanceOrderOperation._MaintenanceOrder.MaintenanceOrderType
}
