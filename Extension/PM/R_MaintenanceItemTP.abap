@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_MI_TP'
@EndUserText.label: 'R_MaintenanceItemTP Extend View'

extend view R_MaintenanceItemTP with ZSM_I_EXT_MI_TP
{
    I_MaintenanceItem.ZZVALUE
}
