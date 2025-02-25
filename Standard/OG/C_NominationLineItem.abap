CDS         :   C_NominationLineItem
Description :   Nomination Line Item

Using       :   left outer join C_NominationLineItem as NLI on NLI.NominationDoc = $projection.NominationDoc

Fields      :   key NLI.NominationDoc,
                key NLI.NominationDocItem,    

Where       :   

Group       :   NLI.NominationDoc,
                NLI.NominationDocItem