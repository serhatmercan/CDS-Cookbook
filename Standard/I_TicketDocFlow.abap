CDS         : I_TicketDocFlow
Definition  : Ticket Item Document Flow

Using       : I_TicketDocFlow as _TDF on _TDF.NominationTicketKey       = $projection.NominationTicketKey
                                     and _TDF.NominationTicketItem      = $projection.NominationTicketItem
                                     and _TDF.NominationTicketVersion   = $projection.NominationTicketVersion
                                     and _TDF.NominationTicketPurpose   = $projection.NominationTicketPurpose

Fields      : key _TDF.NominationTicketKey          as TicketKey,
              key _TDF.NominationTicketItem         as TicketItem,
              key _TDF.NominationTicketPurpose      as TicketPurpose,
              key _TDF.NominationTicketVersion      as TicketVersion,
              key _TDF.TicketSequenceNumber,

                _TDF.IsReversalDocument             as IsReversalDocument,
                _TDF.MaterialDocumentYear           as MaterialDocumentYear,
                _TDF.NominationReferenceDocument    as MaterialDocument,
                _TDF.SDDocumentCategoryName         as DocumentCategoryName,
                _TDF.SourceDocumentItem             as MaterialDocumentItem

Where       : _TDF.MaterialDocumentYear <> '0000'

Group       : 