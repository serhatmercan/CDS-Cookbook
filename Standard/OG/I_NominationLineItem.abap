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
                    NLI.NominationItemIsComplete                                                  as NominationItemIsComplete,  

                    NLI.NominationCarrier                                                         as NominationCarrier,
                    _CarrierName.SupplierFullName                                                 as NominationCarrierName,

                    NLI.NominationPipelineCycleID                                                 as NominationPipelineCycleID,
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
                    NLI._NominationVehicleIdVH.VehicleDescription                                 as VehicleDescription

Where       :   NLI.NominationReferenceDocument <> ''
                and NLI.NominationReferenceDocType in ( 'P', 'T' )
                and ( NLI.NominationScheduleType like 'D%' or NLI.NominationScheduleType like 'O%' )

Group By    :   // no aggregation in this projection - nothing to group

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Line Item
Common Use Cases :   - Main nomination ticket data source; enriches line item with carrier/shipper/
                   contract partner names and vehicle description
Related CDS      :   I_NominationHeaderFld, I_NominationEvent, I_NominationTicketAddlQuantity
Notes            :   - `||` is string concatenation in ABAP CDS, not a logical OR. Alternatives
                     must be written with `in ( ... )` or with explicit `or` predicates - two
                     LIKE patterns cannot be combined with `||`.
                     - The predicates are AND-combined and parenthesised: an OR-chain starting
                     with `ReferenceDocument <> ''` would have made the rest of the filter
                     ineffective.
                     - Demand ("D%") and offer ("O%") schedule types are standard IS-OIL/TSW
                     schedule type values.
Type             :   reference snippet
Context          :   SAP standard reference
