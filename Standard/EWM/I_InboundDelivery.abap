CDS         :   I_InboundDelivery & I_InboundDeliveryItem
Description :   Inbound Delivery  & Inbound Delivery Item

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
Module          :   LE / EWM (Inbound Delivery Processing)
Business Object :   Inbound Delivery
Common Use Cases:   Enrich EWM inbound delivery item data with ERP inbound delivery header/item status (returns indicator, goods movement status)
Notes           :   Join uses right( EWMInboundDelivery, 10 ) to strip the EWM number-range prefix and match the 10-digit ERP delivery number
Related CDS     :   I_EWM_InbDeliveryItemBasic, I_OutboundDelivery