CDS         :   I_DeliveryDocument & I_DeliveryDocumentItem
Definition  :   Delivery Document & Items

Using       :   as select from I_DeliveryDocument     as DD
                    inner join I_DeliveryDocumentItem as DDI        on DDI.DeliveryDocument = DD.DeliveryDocument
                    inner join I_Material             as Material   on Material.Material    = Material.Material

Fields      :   key DDI.ReferenceSDDocument                         as SalesDocument,
                key DDI.ReferenceSDDocumentItem                     as SalesDocumentItem,
                key DDI.Material                                    as Matnr, " Optional Key
                key DDI.Plant                                       as Werks, " Optional Key  

                @Semantics.quantity.unitOfMeasure: 'DeliveryUom'
                sum(DDI.ActualDeliveryQuantity)                     as ActualDeliveryQuantity,
                DDI.DeliveryQuantityUnit                            as DeliveryUom,

                DD.CreationDate,
                
                @Semantics.quantity.unitOfMeasure: 'ITEMWEIGHTUNIT'
                DDI.ItemNetWeight,
                DDI.ItemWeightUnit,

                DDI.StorageLocation                                 as Lgort,
                Material.MaterialType                               as Mtart

Where       :   DDI.GoodsMovementStatus = 'C'
                and( DDI.GoodsMovementType = '601' or DDI.GoodsMovementType = '907' )

Group       :   DDI.ReferenceSDDocument,
                DDI.ReferenceSDDocumentItem,
                DDI.DeliveryQuantityUnit