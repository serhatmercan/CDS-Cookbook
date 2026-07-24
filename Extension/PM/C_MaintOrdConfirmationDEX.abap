@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MOCDEX'

@EndUserText.label: 'C_MaintOrdConfirmationDEX Extend View'

extend view C_MaintOrdConfirmationDEX with ZSM_I_EXT_MOCDEX

{
  I_MaintenanceOrderConfirmation.MaintenanceActivityType,
  I_MaintenanceOrderConfirmation.MaintenanceOrderType,
  I_MaintenanceOrderConfirmation.MaintPriority,
  I_MaintenanceOrderConfirmation.OperationConfirmedStartDate,
  I_MaintenanceOrderConfirmation.Plant,
  I_MaintenanceOrderConfirmation.WorkCenter
}
