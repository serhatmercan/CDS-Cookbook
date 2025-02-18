CDS         : I_NominationLineItem
Definition  : Nomination Ticket Main

Using       : I_NominationLineItem as _NLI on _NLI.NominationDoc     = $projection.NominationDocDQ
                                          and _NLI.NominationDocItem = $projection.NominationDocItemDQ
              
              association [0..1] to I_Supplier as _CarrierName  on _CarrierName.Supplier  = $projection.NominationCarrier
              association [0..1] to I_Supplier as _ContractName on _ContractName.Supplier = $projection.ContractPartner
              association [0..1] to I_Supplier as _ShipperName  on _ShipperName.Supplier  = $projection.NominationShipper

Fields      : key _NLI.NominationDoc                                                             as NominationDoc,
              key _NLI.NominationDocItem                                                         as NominationDocItem,

                  @Semantics.quantity.unitOfMeasure: 'ActualScheduledQuantityUnitDq'
                  _NLI.ActualScheduledQuantity                                                   as ActualScheduledQuantityDq,
                  _NLI.ActualScheduledQuantityUnit                                               as ActualScheduledQuantityUnitDq,
                  
                  _NLI.BatchDestinationLocation                                                  as BatchDestinationLocationDq,
                  _NLI.BatchOriginLocation                                                       as BatchOriginLocationDq,

                  _NLI.ContractPartner                                                           as ContractPartner,
                  _ContractName.SupplierFullName                                                 as ContractPartnerName,

                  _NLI.DemandMaterial                                                            as DemandMaterialDq,
                  _NLI.LocationId                                                                as LocationIdDq,
                  _NLI.LocationName                                                              as LocationNameDq,                  
                  _NLI.MaterialDesc                                                              as MaterialDescDq,
                  _NLI.NominationItemIsComplete                                                  as NominationItemIsComplete,  

                  _NLI.NominationCarrier                                                         as NominationCarrier,
                  _CarrierName.SupplierFullName                                                  as NominationCarrierName,

                  _NLI.NominationPipelineCycleID                                                 as VehicleIdentifierOq,
                  _NLI.NominationRefDocCode                                                      as NominationRefDocCode,
                  _NLI.NominationScheduleDate                                                    as NominationScheduleDateDq,
                  _NLI.NominationScheduleType                                                    as NominationScheduleType,

                  _NLI.NominationShipper                                                         as NominationShipper,
                  _ShipperName.SupplierFullName                                                  as NominationShipperName,

                  _NLI.NominationReferenceDocType                                                as NominationReferenceDocTypeDq,
                  _NLI.NominationReferenceDocument                                               as NominationReferenceDocumentDq,
                  _NLI.NominationReferenceDocItem                                                as NominationReferenceDocItemDq,
                  _NLI.TransportSystem                                                           as TransportSystem,
                  
                  @Semantics.quantity.unitOfMeasure: 'ScheduledQuantityUnitDq'
                  _NLI.ScheduledQuantity                                                         as ScheduledQuantityDq,                  
                  _NLI.ScheduledQuantityUnit                                                     as ScheduledQuantityUnitDq, 
                  
                  _NLI.ValuationTypeDestination                                                  as ValuationTypeDestination,
                  _NLI.ValuationTypeOrigin                                                       as ValuationTypeOrigin,                  
                  
                  _NLI.VehicleId                                                                 as VehicleId,
                  _NLI._NominationVehicleIdVH.VehicleDescription                                 as VehicleDescription,            

Where       :   _NLI.NominationReferenceDocument <> '' or
                _NLI.NominationReferenceDocType = 'T' or
                _NLI.NominationReferenceDocType = 'P' or
                _NLI.NominationScheduleType like 'D%' || 'O%'
              
Group       :   _NLI.NominationReferenceDocument,
                _NLI.NominationReferenceDocItem