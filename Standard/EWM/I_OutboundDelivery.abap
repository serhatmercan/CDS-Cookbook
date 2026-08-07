CDS         :   I_OutboundDelivery & I_OutboundDeliveryItem
Description :   Outbound Delivery Document & Items

Using       :   as select from I_OutboundDelivery       as OD  on OD.Reservation        = I_ReservationDocumentItem.Reservation
                    inner join I_OutboundDeliveryItem   as ODI on ODI.Reservation       = I_ReservationDocumentItem.Reservation
                                                                 and ODI.ReservationItem   = I_ReservationDocumentItem.ReservationItem

Fields      :   key ODI.OutboundDelivery,
                key ODI.OutboundDeliveryItem,

                    " Outbound Delivery Document Items
                    ODI.OrderID

Where       :   ODI.GoodsMovementStatus <> 'C' and 
                ODI.OrderID <> '' ;

Group By    :   
Module          :   LE / SD
Business Object :   Outbound Delivery
Common Use Cases:   Link a reservation (goods issue) to its outbound delivery and source order for status tracking
Notes           :   Where clause excludes cancelled goods movements (GoodsMovementStatus <> 'C') and items without an order reference
Related CDS     :   I_ReservationDocumentItem, I_InboundDelivery