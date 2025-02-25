CDS         :   I_OutboundDelivery & I_OutboundDeliveryItem
Definition  :   Outbound Delivery Document & Items

Using       :   as select from I_OutboundDelivery       as OD  on OD.Reservation        = I_ReservationDocumentItem.Reservation
                    inner join I_OutboundDeliveryItem   as ODI on ODI.Reservation       = I_ReservationDocumentItem.Reservation
                                                                  ODI.ReservationItem   = I_ReservationDocumentItem.ReservationItem

Fields      :   key ODI.OutboundDelivery,
                key ODI.OutboundDeliveryItem,

                    " Outbound Delivery Document Items
                    ODI.OrderID

Where       :   ODI.GoodsMovementStatus <> 'C' and 
                ODI.OrderID <> '' ;

Group       :   