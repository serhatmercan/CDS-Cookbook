CDS         :   I_EWM_InbDeliveryItemBasic
Description :   Inbound Delivery Item Basic

Using       :   as select from I_EWM_InbDeliveryItemBasic as IDIBasic

Fields      :   key IDIBasic.InboundDeliveryUUID        as Vbeln,
                key IDIBasic.InboundDeliveryItemUUID    as Posnr,

                    IDIBasic.Product                    as Matnr,
                    IDIBasic.Batch                      as Charg,
                    IDIBasic.ProductQuantity            as Lgmng,
                    IDIBasic.QuantityUnit               as Meins

Where       :   

Group By    :   
Module          :   EWM
Business Object :   Inbound Delivery Item (EWM)
Common Use Cases:   EWM inbound delivery item basic data for GR / putaway reporting
Related CDS     :   I_InboundDelivery, I_EWM_StockType_2, I_BatchDistinct