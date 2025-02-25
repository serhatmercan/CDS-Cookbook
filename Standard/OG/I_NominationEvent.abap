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

Group       :   _NE.NominationDoc,
                _NE.NominationDocItem,
                _NE.NominationEventType,
                _NE.ActualStartDateFrom