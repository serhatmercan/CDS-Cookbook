CDS         : I_PurgDocScheduleLine
Description : Purchasing Document Schedule Line

Using       : left outer join I_PurgDocScheduleLine as PDSL on PDSL.PurchasingDocument     = $projection.NominationReferenceDocumentOq
                                                           and PDSL.PurchasingDocumentItem = $projection.NominationReferenceDocItemOqR5

Fields      :   key PurchasingDocument,
                key PurchasingDocumentItem,
                key ScheduleLine,

                    PDSL.SchedLineStscDeliveryDate as PlannedPaymentDate

Module           :   MM
Business Object  :   Purchasing Document Schedule Line
Common Use Cases :   - Enriching a nomination reference document/item with its scheduled delivery date
Notes            :   - Field names (NominationReferenceDocumentOq/...) suggest a Commodity/Nomination context, not a plain PO
Related CDS      :   I_PurchaseOrderItem, I_PurchaseOrderScheduleLine