CDS         :   I_DeliveryDocument & I_DeliveryDocumentItem
Description :   Delivery Document & Items

Module           :   SD / LE (Logistics Execution)
Business Object  :   Outbound Delivery

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

Associations Used:

Where       :   DD.DeliveryDocumentType             = 'ZT01'    and
                DDI.DeliveryDocumentItemCategory    = 'KBN'     and
                DDI.GoodsMovementStatus             = 'C'       and
                ( DDI.GoodsMovementType = '601'  or  DDI.GoodsMovementType = '907' )

Group By    :   DDI.ReferenceSDDocument,
                DDI.ReferenceSDDocumentItem,
                DDI.DeliveryQuantityUnit

Common Use Cases :   - Aggregate actual delivered quantity per originating sales document/item for goods-issue reporting

Related CDS      :   I_SalesDocument, I_SalesOrder

Notes            :   - Where-clause hardcodes DeliveryDocumentType 'ZT01' (custom) and GoodsMovementType 601/907 - scoped to a specific goods-issue/return scenario
