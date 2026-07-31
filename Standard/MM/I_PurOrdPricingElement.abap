CDS         :   I_PurOrdPricingElement
Description :   Purchase Order Pricing Element

Using       :   association [1..*] to I_PurOrdPricingElement  as _POPE on _POPE.PurchaseOrder       = I_PurchaseOrderItem.PurchaseOrder
                                                                      and _POPE.PurchaseOrderItem   = I_PurchaseOrderItem.PurchaseOrderItem

Fields      :   key _POPE.PurchaseOrder,
                key _POPE.PurchaseOrderItem,
                key _POPE.PricingDocument,
                key _POPE.PricingDocumentItem,
                key _POPE.PricingProcedureStep,
                key _POPE.PricingProcedureCounter 

Where       :

Group       :

Module           :   MM
Business Object  :   Purchase Order Pricing Element
Associations Used:   _POPE -> I_PurOrdPricingElement on PurchaseOrder, PurchaseOrderItem
Common Use Cases :   - Access purchasing document pricing/condition elements (e.g. surcharges, discounts) per PO item
Related CDS      :   I_PurchaseOrderItem, I_PurchaseOrder