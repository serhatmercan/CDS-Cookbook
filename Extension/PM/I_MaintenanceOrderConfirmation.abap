" ============================================================================
" Extension   : I_MaintenanceOrderConfirmation  (extend view ... with ZSM_I_EXT_MOC)
" Module      : PM
" Business Object : Maintenance Order Confirmation
" ----------------------------------------------------------------------------
" Description
"   Adds work center and order master data fields to the Maintenance Order
"   Confirmation view via existing associations.
"
" Fields Added
"   WorkCenter               - _ActualWorkCenter.WorkCenter
"   MaintenanceActivityType  - _MaintenanceOrder.MaintenanceActivityType
"   MaintPriority             - _MaintenanceOrder.MaintPriority
"   MainWorkCenter            - _MaintenanceOrder.MainWorkCenter
"   MaintenanceOrderType      - _MaintenanceOrderOperation._MaintenanceOrder.MaintenanceOrderType
"
" Associations Used
"   _ActualWorkCenter, _MaintenanceOrder, _MaintenanceOrderOperation (existing, standard)
"
" Common Use Cases
"   - Confirmation list/reporting: show order type, priority and work center
"     without extra navigation
" ============================================================================

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
