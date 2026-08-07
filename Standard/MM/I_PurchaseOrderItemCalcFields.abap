CDS         :   I_PurchaseOrderItemCalcFields  
Description :   Collection of Calculated Fields on PO Item Level

Using       :   association [1..1] to I_PurchaseOrderItemCalcFields as _POICF on _POICF.PurchaseOrder       = I_PurchaseOrderItem.PurchaseOrder 
                                                                             and _POICF.PurchaseOrderItem   = I_PurchaseOrderItem.PurchaseOrderItem

Fields      :   key _POICF.PurchaseOrder,
                key _POICF.PurchaseOrderItem,
                    
                    _POICF.Plant    

Where       :

Group By    :

Module           :   MM
Business Object  :   Purchase Order Item Calculated Fields
Associations Used:   _POICF -> I_PurchaseOrderItemCalcFields on PurchaseOrder, PurchaseOrderItem
Common Use Cases :   - Enriching a PO item with derived/calculated fields not stored directly on I_PurchaseOrderItem
Related CDS      :   I_PurchaseOrderItem