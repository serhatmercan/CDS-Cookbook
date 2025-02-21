CDS         :   I_TicketItemFld
Definition  :   Ticket Items Fields

Using       :   as select from I_TicketItemFld as _TIF on _TIF.NominationDoc     = $projection.NominationDoc
                                                      and _TIF.NominationDocItem = $projection.NominationDocItem

Fields      :   key _TIF.NominationTicketKey,
                key _TIF.NominationTicketItem,
                key _TIF.NominationTicketVersion,
                key _TIF.NominationTicketPurpose,

                    _TIF.NominationDoc,
                    _TIF.NominationDocItem,
                    _TIF.NominationExtNumber,
                    _TIF.NominationScheduleType,
                    _TIF.LocationId,
                    _TIF.TicketCreationDate,
                    _TIF.ScheduledMaterial,
                    _TIF.BaseUnit,
                    _TIF.ScheduledQuantity,
                    _TIF.TicketDocumentPostingDate,
                    _TIF.QuantityStartDateTime,
                    _TIF.QuantityEndDateTime,
                    _TIF.GeneralMeterNumber,
                    _TIF.EndCounterMeterReading,
                    _TIF.OpenMeterDateTime,
                    _TIF.CloseMeterDateTime,
                    _TIF.StopMeterCalculationQuantity,
                    _TIF.StopMeterUnitOfMeasure,
                    _TIF.TankSequenceNumber,
                    _TIF.StorageObjectSegmentNumber,
                    _TIF.OpenTankDipDateTime,
                    _TIF.CloseTankDipDateTime,
                    _TIF.TicketCreatedByUser,
                    _TIF.TicketCreationTime,
                    _TIF.TicketChangedByUser,
                    _TIF.NominationItemStatus,
                    _TIF.NominationItemSubStatus,
                    _TIF.NominationTicketStatus,
                    _TIF.IsNominationItemClosed,
                    _TIF.VehicleId,
                    _TIF.TicketChangedDate,
                    _TIF.NominationEventDate,
                    _TIF.StopGaugeUnitOfMeasure,
                    _TIF.BulkShipmentType,
                    _TIF.OriginPlant,
                    _TIF.OriginStorageLocation,
                    _TIF.DestinationPlant,
                    _TIF.DestinationStorageLocation,
                    _TIF.BatchDestinationLocation

Where       :   _TIF.NominationTicketStatus  =  '00' and 
                _TIF.NominationTicketPurpose <> '5'