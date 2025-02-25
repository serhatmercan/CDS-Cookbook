CDS         :   I_PurchaseOrderItemCalcFields  
Description :   Collection of Calculated Fields on PO Item Level

Using       :   association [1..1] to I_PurchaseOrderItemCalcFields as _POICF on _POICF.PurchaseOrder       = I_PurchaseOrderItem.PurchaseOrder 
                                                                             and _POICF.PurchaseOrderItem   = I_PurchaseOrderItem.PurchaseOrderItem

Fields      :   key _POICF.PurchaseOrder,
                key _POICF.PurchaseOrderItem,
                    
                    _POICF.Plant    

Where       :   

Group       :   