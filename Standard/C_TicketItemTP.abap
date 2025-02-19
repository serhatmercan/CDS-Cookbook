CDS         :   C_TicketItemTP
Definition  :   Tickets Items

Using       :   inner join C_TicketItemTP  as TITP on TITP.NominationDoc = z1.NominationDocOq

Fields      :   key TITP.NominationTicketItem,
                key TITP.NominationTicketKey,
                key TITP.NominationTicketVersion,
                key TITP.NominationDoc,             " Optional

Where       :   

Group       :   