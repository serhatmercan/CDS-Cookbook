@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_TVQ'
@EndUserText.label: 'C_TimeVarianceQuery Extend View'

extend view C_TimeVarianceQuery with ZSM_I_EXT_TVQ
{
    @AnalyticsDetails: {
        internalName    : #LOCAL,
        query: {
            axis        : #ROWS, 
            display     : #KEY
        }
    }
    @EndUserText.label: 'Test III' 
    C_TimeVarianceCube._Material.ProductExternalID as ZZProductExternalID
}
