CDS         :   I_NominationLineItem
Description :   Nomination Ticket Main

Using       :   as select from I_NominationLineItem as NLI on NLI.NominationDoc     = $projection.NominationDocDQ
                                                          and NLI.NominationDocItem = $projection.NominationDocItemDQ
              
                association [0..1] to I_Supplier as _CarrierName  on _CarrierName.Supplier  = $projection.NominationCarrier
                association [0..1] to I_Supplier as _ContractName on _ContractName.Supplier = $projection.ContractPartner
                association [0..1] to I_Supplier as _ShipperName  on _ShipperName.Supplier  = $projection.NominationShipper

Fields      :   key NLI.NominationDoc                                                             as NominationDoc,
                key NLI.NominationDocItem                                                         as NominationDocItem,

                    @Semantics.quantity.unitOfMeasure: 'ActualScheduledQuantityUnitDq'
                    NLI.ActualScheduledQuantity                                                   as ActualScheduledQuantityDq,
                    NLI.ActualScheduledQuantityUnit                                               as ActualScheduledQuantityUnitDq,
                    
                    NLI.BatchDestinationLocation                                                  as BatchDestinationLocationDq,
                    NLI.BatchOriginLocation                                                       as BatchOriginLocationDq,

                    NLI.ContractPartner                                                           as ContractPartner,
                    _ContractName.SupplierFullName                                                as ContractPartnerName,

                    NLI.DemandMaterial                                                            as DemandMaterialDq,
                    NLI.InTransitPlant                                                            as InTransitPlantOq,   
                    NLI.InTransitStorageLocation                                                  as InTransitStorageLocationOq,
                    NLI.LocationId                                                                as LocationIdDq,
                    NLI.LocationName                                                              as LocationNameDq,
                    NLI.LocationPartner                                                           as LocationPartnerOq,                  
                    NLI.MaterialDesc                                                              as MaterialDescDq,
                    NLI.NominationCarrier                                                         as NominationCarrierOq,
                    NLI.NominationItemIsComplete                                                  as NominationItemIsComplete,  

                    NLI.NominationCarrier                                                         as NominationCarrier,
                    _CarrierName.SupplierFullName                                                 as NominationCarrierName,

                    NLI.NominationPipelineCycleID                                                 as VehicleIdentifierOq,
                    NLI.NominationRefDocCode                                                      as NominationRefDocCode,
                    NLI.NominationScheduleDate                                                    as NominationScheduleDateDq,
                    NLI.NominationScheduleType                                                    as NominationScheduleType,

                    NLI.NominationShipper                                                         as NominationShipper,
                    _ShipperName.SupplierFullName                                                 as NominationShipperName,

                    NLI.NominationReferenceDocType                                                as NominationReferenceDocTypeDq,
                    NLI.NominationReferenceDocument                                               as NominationReferenceDocumentDq,
                    NLI.NominationReferenceDocItem                                                as NominationReferenceDocItemDq,
                    NLI.NominationTicketKey                                                       as NominationTicketKeyDq,
                    NLI.NominationTicketItem                                                      as NominationTicketItemDq,
                    NLI.NominationTicketPurpose                                                   as NominationTicketPurposeDq,
                    NLI.NominationTicketVersion                                                   as NominationTicketVersionDq,
                    NLI.TransportSystem                                                           as TransportSystem,
                    
                    @Semantics.quantity.unitOfMeasure: 'ScheduledQuantityUnitDq'
                    NLI.ScheduledQuantity                                                         as ScheduledQuantityDq,                  
                    NLI.ScheduledQuantityUnit                                                     as ScheduledQuantityUnitDq, 
                    
                    NLI.ValuationTypeDestination                                                  as ValuationTypeDestination,
                    NLI.ValuationTypeOrigin                                                       as ValuationTypeOrigin,                  
                    
                    NLI.VehicleId                                                                 as VehicleId,
                    NLI._NominationVehicleIdVH.VehicleDescription                                 as VehicleDescription,            

Where       :   NLI.NominationReferenceDocument <> '' or
                NLI.NominationReferenceDocType = 'P' or
                NLI.NominationReferenceDocType = 'T' or
                NLI.NominationScheduleType like 'D%' || 'O%'
              
Group       :   NLI.NominationReferenceDocument,
                NLI.NominationReferenceDocItem