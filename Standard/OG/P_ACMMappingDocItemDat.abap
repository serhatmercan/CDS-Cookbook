CDS         :   P_ACMMappingDocItemDat
Definition  :   CPE Caller - Mapping KNUMV & Document Item to GUID

Using       :   association [0..1] to P_ACMMappingDocItemDat as _ACMMDID on _ACMMDID.PricingDocument = I_PurchasingDocument.PurchasingDocumentCondition
                                                                        and _ACMMDID.ConditionItem   = I_PurchasingDocument.NominationReferenceDocItemOq

Fields      :   _ACMMDID.ACMPricingDocItemUUID as DocItemGuid

Where       :   

Group       :   