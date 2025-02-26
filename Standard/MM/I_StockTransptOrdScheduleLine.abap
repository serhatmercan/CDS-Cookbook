CDS         :   I_StockTransptOrdScheduleLine
Description :   Stock Transport Order Schedule Line   

Using       :   as select from I_StockTransptOrdScheduleLine as STOSchedule    

Fields      :   key STOSchedule.PurchaseOrder,
                key STOSchedule.PurchaseOrderItem,
                key STOSchedule.ScheduleLine,
                
                    STOSchedule.PurchaseRequisition

Where       :   

Group       :   