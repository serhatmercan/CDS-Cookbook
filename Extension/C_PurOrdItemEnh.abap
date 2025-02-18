@AbapCatalog.sqlViewAppendName: 'ZMM_V_EXT_CPOITM'
@EndUserText.label: 'C_PurOrdItemEnh Extend View'
extend view C_PurOrdItemEnh with ZMM_I_EXT_CPURORDITEMENH
  association [0..1] to zmm_cds_0024 as _v24 on _v24.ebeln = $projection.Purchaseorder     
                                            and _v24.ebelp = $projection.PurchaseOrderItem

{   
    @Consumption.semanticObject: 'zmm_sobj_0001'
    @UI.fieldGroup:[{ 
        qualifier: 'ItemDetails', 
        position: 14
    }]
    @UI.lineItem: [{
        qualifier: 'PurchItem',
        position: 109,
        importance: #HIGH 
    }]
    
    _v24.RequestForQuotation as zmm_rfq_h
}