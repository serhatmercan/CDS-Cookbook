CDS         :   P_ACMMappingDocItemDat
Description :   CPE Caller - Mapping KNUMV & Document Item to GUID

Using       :   association [0..1] to P_ACMMappingDocItemDat as _ACMMDID on _ACMMDID.PricingDocument = I_PurchasingDocument.PurchasingDocumentCondition
                                                                        and _ACMMDID.ConditionItem   = I_PurchasingDocument.NominationReferenceDocItemOq

Fields      :   _ACMMDID.ACMPricingDocItemUUID as DocItemGuid

Where       :   

Group By    :

Module           :   MM / OG (Oil & Gas - CPE Condition Processing Engine)
Business Object  :   Pricing Document Item GUID Mapping
Associations Used:   _ACMMDID -> P_ACMMappingDocItemDat on PricingDocument, ConditionItem
Common Use Cases :   - Resolve the internal GUID for a pricing document/condition item, for use as a
                   join key to an external process (e.g. compliance/condition engine, per view name)
Notes            :   - Business context of 'ACM' not confidently identified from this snippet alone;
                   verify semantics before reuse elsewhere
Release note     :   P_* views belong to the private/internal VDM layer. They are not
                     released reuse APIs: SAP may change or remove them. Treat this file as a
                     record of what was used, and prefer a released alternative if one exists.
Type             :   reference snippet
Context          :   SAP standard reference
