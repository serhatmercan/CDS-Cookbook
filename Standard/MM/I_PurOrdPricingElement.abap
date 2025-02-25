CDS         :   I_PurOrdPricingElement
Definition  :   Purchase Order Pricing Element

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