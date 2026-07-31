CDS         :   I_PurchasingOrganization
Description :   Purchasing Organization

Using       :   association [0..1] to I_PurchasingOrganization as _PO on _PO.PurchasingOrganization = $projection.PurchasingOrganization

Fields      :   _PO

Where       :

Group       :

Module           :   MM
Business Object  :   Purchasing Organization (master data)
Associations Used:   _PO -> I_PurchasingOrganization on PurchasingOrganization
Common Use Cases :   - Purchasing organization text/attribute lookup enrichment
Related CDS      :   I_PurchasingGroup