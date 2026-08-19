CDS         :   I_PurchasingGroup
Description :   Purchasing Group

Using       :   association [0..1] to I_PurchasingGroup as _PG on _PG.PurchasingGroup = $projection.PurchasingGroup

Fields      :   _PG

Where       :

Group By    :

Module           :   MM
Business Object  :   Purchasing Group (master data)
Associations Used:   _PG -> I_PurchasingGroup on PurchasingGroup
Common Use Cases :   - Purchasing group text/attribute lookup enrichment
Related CDS      :   I_PurchasingOrganization
