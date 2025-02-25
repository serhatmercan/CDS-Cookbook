CDS         :   I_EWM_InbDeliveryItemBasic
Definition  :   Inbound Delivery Item Basic

Using       :   as select from I_EWM_InbDeliveryItemBasic as IDIBasic

Fields      :   key IDIBasic.InboundDeliveryUUID        as Vbeln,
                key IDIBasic.InboundDeliveryItemUUID    as Posnr,

                    IDIBasic.Product                    as Matnr,
                    IDIBasic.Batch                      as Charg,
                    IDIBasic.ProductQuantity            as Lgmng,
                    IDIBasic.QuantityUnit               as Meins

Where       :   

Group       :   