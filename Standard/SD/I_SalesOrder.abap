CDS         :   I_SalesOrder    &   I_SalesOrderItem
Description :   Sales Order     &   Sales Order Items

Using       :   left outer join I_SalesOrder        as SO   on SO.SalesOrder        = I_NominationLineItem.NominationReferenceDocument
                left outer join I_SalesOrderItem    as SOI  on SOI.SalesOrder       = I_NominationLineItem.NominationReferenceDocument 
                                                           and SOI.SalesOrderItem   = I_NominationLineItem.NominationReferenceDocItem
                left outer join but000              as SPT  on SPT.partner          = I_SalesOrder.SoldToParty                                                           

                association [0..1] to I_DistributionChannelText as _DCT     on _DCT.DistributionChannel = I_SalesOrder.DistributionChannel
                                                                           and _DCT.Language            = $session.system_language
                association [0..1] to I_DivisionText            as _DT      on _DT.Division             = I_SalesOrder.OrganizationDivision
                                                                           and _DT.Language             = $session.system_language
                association [0..1] to I_SalesOrganizationText   as _SOT     on _SOT.SalesOrganization   = I_SalesOrder.SalesOrganization
                                                                           and _SOT.Language            = $session.system_language
                association [0..1] to I_ShippingTypeText        as _STT     on _STT.ShippingType        = I_SalesOrder.ShippingType
                                                                           and _STT.Language            = $session.system_language                                                                           

Fields      :   key SOI.SalesOrder,
                key SOI.SalesOrderItem,
                
                " Sales Order
                SO.DeliveryBlockReason,

                SO.DistributionChannel,
                _DT.DistributionChannelName,

                SO.OrganizationDivision,
                _DT.DivisionName,

                SO.SalesOrganization,
                _SOT.SalesOrganizationName,
      
                SO.ShippingType,
                _STT.ShippingTypeName,
      
                SO.SoldToParty,
                SPT.name_org1                   as SoldToPartyDesc,

                " Sales Order Items
                SOI.CommittedDeliveryDate,

                @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
                SOI.ItemGrossWeight,
                SOI.ItemWeightUnit,

                @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
                SOI.ItemVolume,
                SOI.ItemVolumeUnit,

                SOI.Material,
                SOI.SalesDocumentRjcnReason,

                @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
                SOI.OrderQuantity,
                SOI.OrderQuantityUnit,

Where       :   SO.DeliveryBlockReason      = '' and
                ( SO.SalesOrganization = '1200' or SO.SalesOrganization = '1300' or SO.SalesOrganization = '1400' )
                ( SO.ShippingType      = '10'   or SO.ShippingType      = '40' ) and
                SOI.SalesDocumentRjcnReason = ''

Group       :   