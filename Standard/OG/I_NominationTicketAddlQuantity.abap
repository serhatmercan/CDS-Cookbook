CDS         :   I_NominationTicketAddlQuantity
Description :   Nomination Ticket Additional Quantity

Using       :   left outer join I_NominationTicketAddlQuantity as NTAQ on NTAQ.NominationTicketKey  = C_TicketItemTP.NominationTicketKey
                                                                      and NTAQ.NominationTicketItem = C_TicketItemTP.NominationTicketItem 

Fields      :   key NTAQ.NominationTicketKey,
                key NTAQ.NominationTicketItem,
                key NTAQ.NominationTicketVersion,
                key NTAQ.NominationTicketPurpose,
                key NTAQ.NominationTicketUoM,

                    NTAQ.NominationTicketQuantity

Where       :   

Group       :   