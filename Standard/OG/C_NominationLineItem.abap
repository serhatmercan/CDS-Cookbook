CDS         :   C_NominationLineItem
Description :   Nomination Line Item

Using       :   left outer join C_NominationLineItem as NLI on NLI.NominationDoc = $projection.NominationDoc

Fields      :   key NLI.NominationDoc,
                key NLI.NominationDocItem

Where       :   

Group By    :   // key-only projection - no aggregation, nothing to group

Module           :   OG (Oil & Gas - TSW / Nomination Management)
Business Object  :   Nomination Line Item (consumption view)
Common Use Cases :   - Key-only consumption projection of nomination line items, typically used as
                   a value-help / association target
