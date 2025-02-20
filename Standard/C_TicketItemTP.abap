CDS         :   C_TicketItemTP
Definition  :   Tickets Items

Using       :   inner join C_TicketItemTP  as TITP on TITP.NominationDoc     = I_NominationLineItem.NominationDoc
                                                  and TITP.NominationDocItem = I_NominationLineItem.NominationDocItem

Fields      :   key TITP.NominationTicketItem,
                key TITP.NominationTicketKey,
                key TITP.NominationTicketVersion,
                key TITP.NominationDoc,             " Optional
                    
                    TITP.BaseUnit,
                    TITP.DestinationPlant,
                    TITP.NominationItemSubStatus,
                    TITP.NominationTicketType,
                    TITP.OriginPlant,
                    TITP.OriginStorageLocation,
                    TITP.ScheduledMaterial,
                    TITP.TankSequenceNumber,
                    TITP.TicketCreatedByUser,
                    TITP.TicketDocumentPostingDate,
                    TITP.TicketExternalNumber,
                    TITP.TypeOfMovement
 
Where       :   

Group       :   TITP.NominationTicketKey,
                TITP.NominationTicketItem   