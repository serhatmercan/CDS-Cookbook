CDS         :   P_ABOPStaticWhereConditionSTO 
Description :   ABOP Static Where Condition for Stock Transport Order   

Using       :   inner join P_ABOPStaticWhereConditionSTO as ABOPStatic on ABOPStatic.ATPRelevantDocument        = I_StockTransptOrdScheduleLine.PurchaseOrder 
                                                                      and ABOPStatic.ATPRelevantDocumentItem    = I_StockTransptOrdScheduleLine.PurchaseOrderItem 
                                                                      and ABOPStatic.ATPRelevantDocScheduleLine = I_StockTransptOrdScheduleLine.ScheduleLine      

Fields      :    

Where       :

Group By    :

Module           :   MM / SD (Advanced ATP)
Business Object  :   ABOP Static Where Condition for Stock Transport Orders
Associations Used:   plain join on ATPRelevantDocument, ATPRelevantDocumentItem, ATPRelevantDocScheduleLine
Common Use Cases :   - Restricting/scoping STO schedule lines that are relevant for aATP backorder processing (BOP)
Notes            :   - Part of the standard Advanced ATP (ABOP) framework; normally consumed, not modified
Related CDS      :   I_StockTransptOrdScheduleLine
Release note     :   P_* views belong to the private/internal VDM layer. They are not
                     released reuse APIs: SAP may change or remove them. Treat this file as a
                     record of what was used, and prefer a released alternative if one exists.
Type             :   reference snippet
Context          :   SAP standard reference
