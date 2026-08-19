CDS         :   I_NominationHeaderFld & I_NominationItemFld
Description :   Nomination Header Table Fields & Item Table Fields

Using       :   association [0..1] to I_NominationHeaderFld     as _NHF             on _NHF.NominationDoc               = $projection.NominationDocOQ
                association [0..1] to I_NominationItemFld       as _NIF             on _NIF.NominationDoc               = $projection.NominationDocOQ
                                                                                   and _NIF.NominationDocItem           = $projection.NominationDocItemOQ
                association [0..1] to I_NominationVehicleIdVH   as _NVHIVH          on _NVHIVH.VehicleId                = $projection.VehicleId
                association [0..1] to I_NominationMaterialDesc  as _MaterialText    on _MaterialText.ScheduledMaterial  = $projection.DemandMaterial
                association [0..1] to I_Supplier                as _CarrierName     on _CarrierName.Supplier            = $projection.NominationCarrier
                association [0..1] to I_Supplier                as _ContractName    on _ContractName.Supplier           = $projection.ContractPartner
                association [0..1] to I_Supplier                as _ShipperName     on _ShipperName.Supplier            = $projection.NominationShipper

Fields      :   key _NIF.NominationDoc,
                key _NIF.NominationDocItem,

                    // Nomination Header Table Fields
                    _NHF.NominationPipelineCycleID,
                    _NHF.TransportSystem,

                    _NHF.VehicleId,
                    _NVHIVH.VehicleDescription                                      as VehicleDescription,

                    // Nomination Item Table Fields
                    _NIF.ActualScheduledQuantity,
                    _NIF.ActualScheduledQuantityUnit,
                    _NIF.BatchDestinationLocation,
                    _NIF.BatchOriginLocation,

                    _NIF.ContractPartner,
                    _ContractName.SupplierName                                      as ContractPartnerName,
                    _ContractName.Country                                           as SupplierCountry,

                    _NIF.DemandMaterial,
                    _MaterialText.MaterialDesc                                      as MaterialDesc,

                    _NIF.NominationItemIsComplete,
                     
                    _NIF.LocationId,
                    _NIF.LocationName,

                    _NIF.NominationCarrier,
                    _CarrierName.SupplierFullName                                   as NominationCarrierName,
                    
                    _NIF.NominationRefDocCode,
                    _NIF.NominationReferenceDocument,

                    _NIF.NominationReferenceDocItem,
                    right(_NIF.NominationReferenceDocItem, 5)                       as NominationReferenceDocItemR5,
                    
                    _NIF.NominationReferenceDocType,
                    _NIF.NominationScheduleDate,
                    _NIF.NominationScheduleType,

                    _NIF.NominationShipper,
                    _ShipperName.SupplierFullName                                   as NominationShipperName,
                    
                    _NIF.NominationType,

                    @Semantics.quantity.unitOfMeasure: 'ScheduledQuantityUnit'
                    _NIF.ScheduledQuantity,
                    _NIF.ScheduledQuantityUnit,

                    
                    _NIF.ValuationTypeDestination,
                    _NIF.ValuationTypeOrigin

Where       :   _NIF.NominationIsMarkedForDeletion =  ''                                            and
                _NIF.NominationScheduleType in ( 'OQ', 'OS' )                                       and
                _NIF.NominationReferenceDocType = 'P'

Group By    :   // field-reference snippet - no aggregation, nothing to group

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Header / Item Fields
Common Use Cases :   - Enrich nomination line items with header, vehicle, material and business partner
                   (carrier/shipper/contract partner) descriptions
Notes            :   - Filtered to NominationScheduleType OQ/OS and NominationReferenceDocType 'P'
                     - The redundant LIKE 'D%' / 'O%' predicate was dropped: it was subsumed
                     by the schedule-type IN list on the next line.
                     - The OQ header association pairs with the OQ item, not the DQ item.
                     - Schedule types OQ/OS and reference doc type 'P' are standard IS-OIL/TSW
                     values; adapt them to the flow you need.
Type             :   reference snippet (field reference)
Context          :   SAP standard reference
