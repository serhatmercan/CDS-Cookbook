CDS         :   I_DeliveryDocument & I_DeliveryDocumentItem
Description :   Delivery Document & Items

Module           :   SD / LE (Logistics Execution)
Business Object  :   Outbound Delivery

Using       :   as select from I_DeliveryDocument     as DD
                    inner join I_DeliveryDocumentItem as DDI        on DDI.DeliveryDocument = DD.DeliveryDocument
                    inner join I_Material             as Material   on Material.Material    = DDI.Material

Fields      :   // Aggregation level = the originating sales document item, so the
                // delivery-item key is NOT part of the projection: every element
                // below is either a grouping key or an aggregate.
                key DDI.ReferenceSDDocument                         as SalesDocument,
                key DDI.ReferenceSDDocumentItem                     as SalesDocumentItem,
                key DDI.Material                                    as Matnr,
                key DDI.Plant                                       as Werks,

                    DDI.DeliveryQuantityUnit                        as DeliveryUom,
                    DDI.BaseUnit                                    as Meins,
                    Material.MaterialType                           as Mtart,

                    @Semantics.quantity.unitOfMeasure: 'DeliveryUom'
                    sum(DDI.ActualDeliveryQuantity)                 as ActualDeliveryQuantity,

                    @Semantics.quantity.unitOfMeasure: 'DeliveryUom'
                    sum(DDI.OriginalDeliveryQuantity)               as OriginalDeliveryQuantity

Associations Used:

Where       :   DDI.GoodsMovementStatus  = 'C'   and   // goods movement completed
                DDI.GoodsMovementType    = '601'       // standard goods issue for delivery
                // Delivery type, item category and any additional (custom) movement
                // types are configuration. Add your own scope, e.g.:
                //   and DD.DeliveryDocumentType          in ( ... )
                //   and DDI.DeliveryDocumentItemCategory in ( ... )
                //   and DDI.GoodsMovementType            in ( '601', ... )

Group By    :   DDI.ReferenceSDDocument,
                DDI.ReferenceSDDocumentItem,
                DDI.Material,
                DDI.Plant,
                DDI.DeliveryQuantityUnit,
                DDI.BaseUnit,
                Material.MaterialType

Common Use Cases :   - Aggregate actual delivered quantity per originating sales document/item for goods-issue reporting

Related CDS      :   I_SalesDocument, I_SalesOrder

Notes            :   - Complete aggregation pattern: the projection contains only grouping keys
                     and aggregates, so the GROUP BY matches it exactly. Adding delivery-item
                     detail fields would require adding them to the GROUP BY too.
                     - The material join is on DDI.Material; an ON condition of the form
                     Material.Material = Material.Material is a Cartesian product against the
                     whole material master.
                     - Delivery type, item category and custom movement types are configuration
                     and are intentionally not hard-coded.
Type             :   reference snippet (complete aggregation pattern)
Context          :   SAP standard reference
