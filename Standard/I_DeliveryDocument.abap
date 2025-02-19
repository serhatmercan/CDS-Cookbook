CDS         :   I_DeliveryDocument & I_DeliveryDocumentItem
Definition  :   Delivery Document & Items

Using       :   as select from I_DeliveryDocument     as DD
                    inner join I_DeliveryDocumentItem as DDI        on DDI.DeliveryDocument = DD.DeliveryDocument
                    inner join I_Material             as Material   on Material.Material    = Material.Material

Fields      :   key DDI.DeliveryDocument,
                key DDI.DeliveryDocumentItem,
                key DDI.ReferenceSDDocument                         as SalesDocument,       " Optional Key
                key DDI.ReferenceSDDocumentItem                     as SalesDocumentItem,   " Optional Key
                key DDI.Material                                    as Matnr,               " Optional Key
                key DDI.Plant                                       as Werks,               " Optional Key  

                    " Delivery Document
                    DD.ActualGoodsMovementDate,
                    DD.CreationDate,
                    DD.DeliveryDocumentType,
                    DD.OverallGoodsMovementStatus,
                    DD.OverallProofOfDeliveryStatus,
                    DD.ProofOfDeliveryDate,
                    DD.SDDocumentCategory,

                    " Delivery Document Items
                    DDI.BaseUnit                                        as Meins,
                    DDI.DeliveryDocumentItemCategory,
                    DDI.DistributionChannel,

                    @Semantics.quantity.unitOfMeasure: 'DeliveryUom'
                    sum(DDI.ActualDeliveryQuantity)                     as ActualDeliveryQuantity,
                    DDI.DeliveryQuantityUnit                            as DeliveryUom,
                    
                    DDI.GoodsMovementType                               as Bwart,

                    @Semantics.quantity.unitOfMeasure: 'ITEMWEIGHTUNIT'
                    DDI.ItemNetWeight,
                    DDI.ItemWeightUnit,

                    @Semantics.quantity.unitOfMeasure: 'DeliveryUom'                    
                    DDI.OriginalDeliveryQuantity,

                    DDI.StorageLocation                                 as Lgort,
                    
                    " Material
                    Material.MaterialType                               as Mtart

Where       :   DD.DeliveryDocumentType             = 'ZT01'    and
                DDI.DeliveryDocumentItemCategory    = 'KBN'     and
                DDI.GoodsMovementStatus             = 'C'       and
                ( DDI.GoodsMovementType = '601'  or  DDI.GoodsMovementType = '907' )

Group       :   DDI.ReferenceSDDocument,
                DDI.ReferenceSDDocumentItem,
                DDI.DeliveryQuantityUnit