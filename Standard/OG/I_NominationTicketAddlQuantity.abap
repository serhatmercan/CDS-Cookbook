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

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Ticket Additional Quantity
Common Use Cases :   - Additional ticket quantities recorded in alternate units of measure (e.g. std/
                   net/gross volumes) alongside the main ticket quantity
