CDS         : P_ACMMappingDocItemDat
Definition  : CPE Caller - Mapping KNUMV & Document Item to GUID

Using       : P_ACMMappingDocItemDat as _ACMMDID on _ACMMDID.PricingDocument = $projection.PurchasingDocumentCondition
                                                and _ACMMDID.ConditionItem   = $projection.NominationReferenceDocItemOq

Fields      : _ACMMDID.ACMPricingDocItemUUID as DocItemGuid