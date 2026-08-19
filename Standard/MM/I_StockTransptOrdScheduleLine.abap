CDS         :   I_StockTransptOrdScheduleLine
Description :   Stock Transport Order Schedule Line   

Using       :   as select from I_StockTransptOrdScheduleLine as STOSchedule    

Fields      :   key STOSchedule.PurchaseOrder,
                key STOSchedule.PurchaseOrderItem,
                key STOSchedule.ScheduleLine,
                
                    STOSchedule.PurchaseRequisition

Where       :

Group By    :

Module           :   MM
Business Object  :   Stock Transport Order Schedule Line
Common Use Cases :   - Retrieving the originating purchase requisition for an STO schedule line
Related CDS      :   I_PurchaseOrderItem, I_PurchaseOrder
