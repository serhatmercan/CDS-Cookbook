CDS         :   P_ABOPStaticWhereConditionSTO 
Description :   ABOP Static Where Condition for Stock Transport Order   

Using       :   inner join P_ABOPStaticWhereConditionSTO as ABOPStatic on ABOPStatic.ATPRelevantDocument        = I_StockTransptOrdScheduleLine.PurchaseOrder 
                                                                      and ABOPStatic.ATPRelevantDocumentItem    = I_StockTransptOrdScheduleLine.PurchaseOrderItem 
                                                                      and ABOPStatic.ATPRelevantDocScheduleLine = I_StockTransptOrdScheduleLine.ScheduleLine      

Fields      :    

Where       :

Group       :

Module           :   MM / SD (Advanced ATP)
Business Object  :   ABOP Static Where Condition for Stock Transport Orders
Associations Used:   plain join on ATPRelevantDocument, ATPRelevantDocumentItem, ATPRelevantDocScheduleLine
Common Use Cases :   - Restricting/scoping STO schedule lines that are relevant for aATP backorder processing (BOP)
Notes            :   - Part of the standard Advanced ATP (ABOP) framework; normally consumed, not modified
Related CDS      :   I_StockTransptOrdScheduleLine