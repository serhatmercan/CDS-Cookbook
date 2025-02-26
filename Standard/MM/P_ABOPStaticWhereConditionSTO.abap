CDS         :   P_ABOPStaticWhereConditionSTO 
Description :   ABOP Static Where Condition for Stock Transport Order   

Using       :   inner join P_ABOPStaticWhereConditionSTO as ABOPStatic on ABOPStatic.ATPRelevantDocument        = I_StockTransptOrdScheduleLine.PurchaseOrder 
                                                                      and ABOPStatic.ATPRelevantDocumentItem    = I_StockTransptOrdScheduleLine.PurchaseOrderItem 
                                                                      and ABOPStatic.ATPRelevantDocScheduleLine = I_StockTransptOrdScheduleLine.ScheduleLine      

Fields      :    

Where       :   

Group       :   