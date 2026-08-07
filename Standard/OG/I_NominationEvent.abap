CDS         :   I_NominationEvent
Description :   Nomination Events

Using       :   association [0..1] to I_NominationEvent as _NE on _NE.NominationDoc         = I_NominationLineItem.NominationDoc
                                                              and _NE.NominationDocItem     = I_NominationLineItem.NominationDocItem
                                                              and _NE.NominationEventNumber = $projection.NominationEventNumber
                                                              and _NE.delind                = ''  
                                                              and _NE.NominationEventType   = 'COD' || 'ETA' || 'NOR'

Fields      :   key _NE.NominationDoc,
                key _NE.NominationDocItem,
                key _NE.NominationEventType,
              
                    _NE.ActualStartDateFrom,
                    _NE.delind,

                    max(_NE.NominationEventNumber) as NominationEventNumber,

                    _NE.PlannedStartDateFrom

Where       : 

Group By    :   _NE.NominationDoc,
                _NE.NominationDocItem,
                _NE.NominationEventType,
                _NE.ActualStartDateFrom

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Event
Common Use Cases :   - Retrieve nomination event dates (e.g. COD/ETA/NOR) per nomination line item
Notes            :   - Filtered to event types COD (Change of Destination), ETA, NOR only
