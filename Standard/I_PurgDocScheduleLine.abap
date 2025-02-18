CDS         : I_PurgDocScheduleLine
Definition  : Purchasing Document Schedule Line

Using       : I_PurgDocScheduleLine as _PDSL on _PDSL.PurchasingDocument     = $projection.NominationReferenceDocumentOq
                                            and _PDSL.PurchasingDocumentItem = $projection.NominationReferenceDocItemOqR5

Fields      : _PDSL.SchedLineStscDeliveryDate as PlannedPaymentDate