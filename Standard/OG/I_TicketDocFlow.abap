CDS         :   I_TicketDocFlow
Description :   Ticket Item Document Flow

Using       :   inner join I_TicketDocFlow as TDF on TDF.NominationTicketKey     = $projection.NominationTicketKey
                                                 and TDF.NominationTicketItem    = $projection.NominationTicketItem
                                                 and TDF.NominationTicketVersion = $projection.NominationTicketVersion
                                                 and TDF.NominationTicketPurpose = $projection.NominationTicketPurpose

Fields      :   key TDF.NominationTicketKey             as TicketKey,
                key TDF.NominationTicketItem            as TicketItem,
                key TDF.NominationTicketPurpose         as TicketPurpose,
                key TDF.NominationTicketVersion         as TicketVersion,
                key TDF.TicketSequenceNumber,

                    TDF.DocumentCategoryText,
                    TDF.DocumentReturnCode,
                    TDF.IsReversalDocument,
                    TDF.MaterialDocumentYear,
                    TDF.NominationDocIsBlocked,
                    TDF.NominationReferenceDocument     as MaterialDocument,
                    TDF.NominationTicketIsBlocked,
                    TDF.NominationTicketType,
                    TDF.SDDocumentCategoryName          as DocumentCategoryName,
                    TDF.SourceDocumentItem              as MaterialDocumentItem,
                    TDF.TicketDocumentStatus,

Where       :   TDF.MaterialDocumentYear <> '0000'

Group       : 