CDS         :   I_NominationEvent
Description :   Nomination Events

Using       :   association [0..*] to I_NominationEvent as _NE on _NE.NominationDoc         = I_NominationLineItem.NominationDoc
                                                              and _NE.NominationDocItem     = I_NominationLineItem.NominationDocItem
                                                              and _NE.delind                = ''
                                                              and _NE.NominationEventType   in ( 'COD', 'ETA', 'NOR' )

Fields      :   key _NE.NominationDoc,
                key _NE.NominationDocItem,
                key _NE.NominationEventType,

                    _NE.ActualStartDateFrom,
                    _NE.PlannedStartDateFrom,

                    max(_NE.NominationEventNumber) as LatestEventNumber

Where       :

Group By    :   _NE.NominationDoc,
                _NE.NominationDocItem,
                _NE.NominationEventType,
                _NE.ActualStartDateFrom,
                _NE.PlannedStartDateFrom

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Event
Common Use Cases :   - Retrieve nomination event dates (e.g. COD/ETA/NOR) per nomination line item
Notes            :   - Filtered to event types COD (Change of Destination), ETA, NOR only
                     - A to-many association is filtered to the relevant event types; the
                     max() aggregation picks the latest event number per event type.
                     Do not filter the association on the aggregate it produces - that
                     would be circular.
Type             :   reference snippet (complete aggregation pattern)
Context          :   SAP standard reference
