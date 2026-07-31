CDS         :   P_ACMMappingDocItemDat
Description :   CPE Caller - Mapping KNUMV & Document Item to GUID

Using       :   association [0..1] to P_ACMMappingDocItemDat as _ACMMDID on _ACMMDID.PricingDocument = I_PurchasingDocument.PurchasingDocumentCondition
                                                                        and _ACMMDID.ConditionItem   = I_PurchasingDocument.NominationReferenceDocItemOq

Fields      :   _ACMMDID.ACMPricingDocItemUUID as DocItemGuid

Where       :   

Group       :   

Common Use Cases :   - Resolve the internal GUID for a pricing document/condition item, for use as a
                   join key to an external process (e.g. compliance/condition engine, per view name)
Notes            :   - Business context of 'ACM' not confidently identified from this snippet alone;
                   verify semantics before reuse elsewhere
