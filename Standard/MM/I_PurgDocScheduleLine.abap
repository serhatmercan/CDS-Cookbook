CDS         : I_PurgDocScheduleLine
Description : Purchasing Document Schedule Line

Using       : left outer join I_PurgDocScheduleLine as PDSL on PDSL.PurchasingDocument     = $projection.NominationReferenceDocumentOq
                                                           and PDSL.PurchasingDocumentItem = $projection.NominationReferenceDocItemOqR5

Fields      :   key PurchasingDocument,
                key PurchasingDocumentItem,
                key ScheduleLine,
                
                    PDSL.SchedLineStscDeliveryDate as PlannedPaymentDate