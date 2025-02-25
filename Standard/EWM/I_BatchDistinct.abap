CDS         :   I_BatchDistinct
Description :   Batch Information by Batch Key

Using       :   left outer join I_BatchDistinct as BatchDistinct on BatchDistinct.Material  = I_Product.Product
                                                                and BatchDistinct.Batch     = I_EWM_InbDeliveryItemBasic.Batch

Fields      :   key BatchDistinct.Plant,
                key BatchDistinct.Material,
                key BatchDistinct.Batch,

                    BatchDistinct.ShelfLifeExpirationDate as Vfdat

Where       :   

Group       :   