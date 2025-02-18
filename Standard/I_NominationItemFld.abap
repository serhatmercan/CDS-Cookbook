CDS         : I_NominationItemFld
Definition  : Nomination Item Table Fields

Using       : I_NominationItemFld      as _NIF          on _NIF.NominationDoc              = $projection.nominationDocDQ
                                                       and _NIF.NominationDocItem          = $projection.nominationDocItemDQ

              I_Supplier               as _CarrierName  on _CarrierName.Supplier           = $projection.NominationCarrier
              I_Supplier               as _ContractName on _ContractName.Supplier          = $projection.ContractPartner
              I_NominationMaterialDesc as _MaterialText on _MaterialText.ScheduledMaterial = $projection.DemandMaterial
              I_Supplier               as _ShipperName  on _ShipperName.Supplier           = $projection.NominationShipper

Fields      : key _NIF.nominationDocOQ,
              key _NIF.nominationDocItemOQ,
              
              @Semantics.quantity.unitOfMeasure: 'ScheduledQuantityUnit'
              sum( _NIF.ScheduledQuantity )                                 as ScheduledQuantity,
              
              _NIF.ActualScheduledQuantity,
              _NIF.ActualScheduledQuantityUnit,
              _NIF.BatchDestinationLocation, 
              _NIF.BatchOriginLocation,

              _NIF.ContractPartner,
              _ContractName.SupplierName                                    as ContractPartnerName,
              _ContractName.Country                                         as SupplierCountry,

              _NIF.DemandMaterial,
              _MaterialText.MaterialDesc                                    as MaterialDesc,
              
              _NIF.NominationItemIsComplete,
              _NIF.LocationId,
              _NIF.LocationName,

              _NIF.NominationCarrier,
              _CarrierName.SupplierFullName                                 as NominationCarrierName,
              
              _NIF.NominationRefDocCode,
              _NIF.NominationReferenceDocument,

              _NIF.NominationReferenceDocItem,
              right(_NIF.NominationReferenceDocItem, 5)                     as NominationReferenceDocItemR5,
              
              _NIF.NominationReferenceDocType,
              _NIF.NominationScheduleDate,
              _NIF.NominationScheduleType,

              _NIF.NominationShipper,
              _ShipperName.SupplierFullName                                 as NominationShipperName,
              
              _NIF.NominationType,
              _NIF.ScheduledQuantity,
              _NIF.ScheduledQuantityUnit,
              _NIF.TransportSystem,
              _NIF.ValuationTypeDestination,
              _NIF.ValuationTypeOrigin