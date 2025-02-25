CDS         :   I_InboundDelivery & I_InboundDeliveryItem
Definition  :   Inbound Delivery  & Inbound Delivery Item

Using       :   inner join I_InboundDelivery        as InboundDelivery      on InboundDelivery.InboundDelivery      = right( I_EWM_InbDeliveryItemBasic.EWMInboundDelivery, 10 )
                inner join I_InboundDeliveryItem    as InboundDeliveryItem  on InboundDeliveryItem.InboundDelivery  = right( I_EWM_InbDeliveryItemBasic.EWMInboundDelivery, 10 )

Fields      :   key InboundDeliveryItem.InboundDelivery,
                key InboundDeliveryItem.InboundDeliveryItem,

                    " Inbound Delivery 
                    InboundDelivery.IsReturnsItem,

                    " Inbound Delivery Item
                    InboundDeliveryItem.OverallGoodsMovementStatus

Where       :   

Group       :   