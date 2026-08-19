CDS         :   I_EWM_StockType_2
Description :   Warehouse Stock Type

Using       :   inner join I_EWM_StockType_2 as StockType on StockType.EWMWarehouse = I_EWM_InbDeliveryItemBasic.EWMWarehouse
                                                         and StockType.EWMStockType = I_EWM_InbDeliveryItemBasic.EWMStockType

Fields      :   key StockType.EWMWarehouse,
                key StockType.EWMStockType,
                
                StockType.EWMAvailabilityGroup  as Lgort

Where       :   

Group By    :   
Module          :   EWM
Business Object :   EWM Stock Type
Common Use Cases:   Map EWM warehouse/stock type to an availability group (used as pseudo storage location in reporting)
Related CDS     :   I_EWM_InbDeliveryItemBasic
