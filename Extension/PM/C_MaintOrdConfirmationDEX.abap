" ============================================================================
" Extension   : C_MaintOrdConfirmationDEX  (extend view ... with ZSM_I_EXT_MOCDEX)
" Module      : PM
" Business Object : Maintenance Order Confirmation (Data Extraction)
" ----------------------------------------------------------------------------
" Description
"   Adds order/operation master data fields to the Maintenance Order
"   Confirmation extraction view, sourced from I_MaintenanceOrderConfirmation.
"
" Fields Added
"   MaintenanceActivityType    - I_MaintenanceOrderConfirmation.MaintenanceActivityType
"   MaintenanceOrderType       - I_MaintenanceOrderConfirmation.MaintenanceOrderType
"   MaintPriority               - I_MaintenanceOrderConfirmation.MaintPriority
"   OperationConfirmedStartDate - I_MaintenanceOrderConfirmation.OperationConfirmedStartDate
"   Plant                       - I_MaintenanceOrderConfirmation.Plant
"   WorkCenter                  - I_MaintenanceOrderConfirmation.WorkCenter
"
" Common Use Cases
"   - Data extraction / reporting on maintenance order confirmations
" ============================================================================

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
