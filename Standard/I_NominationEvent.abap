CDS         :   I_NominationEvent
Definition  :   Nomination Events

Using       :   association [0..1] to I_NominationEvent as _NE on _NE.NominationDoc         = $projection.NominationDoc
                                                              and _NE.NominationDocItem     = $projection.NominationDocItem
                                                              and _NE.NominationEventNumber = $projection.NominationEventNumber
                                                              and _NE.delind                = ''  
                                                              and _NE.NominationEventType   = 'COD' || 'ETA' || 'NOR'

Fields      :   key NominationDoc,
                key NominationDocItem,
                key NominationEventType,
              
                max(NominationEventNumber) as NominationEventNumber,
              
                ActualStartDateFrom        as ActualEtaDate,
                PlannedStartDateFrom       as PlanningNorDate              

Where       : 

Group       : NominationDoc,
              NominationDocItem,
              NominationEventType