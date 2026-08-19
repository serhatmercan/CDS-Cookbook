CDS         :   R_PurchasingDocumentItem
Description :   Purchasing Document Item

Using       :   as select from R_PurchasingDocumentItem as RDI // on RDI.PurchasingDocument = I_PurchaseOrder.PurchaseOrder

Fields      :   key RDI.PurchasingDocument,
                key RDI.PurchasingDocumentItem,

                    RDI.PurchaseOrderCategory,
                    RDI.PurchasingDocumentItemUniqueID
                    

Where       :

Group By    :

Module           :   MM
Business Object  :   Purchasing Document Item (generic, RAP-released)
Common Use Cases :   - Generic lookup of purchasing document category/unique ID across document types (PO, PReq, contract, ...)
Related CDS      :   I_PurchaseOrder, I_PurchaseOrderItem
// Release note: R_* views are restricted-use RAP interface views. Verify the
// release/extensibility status of the target in your system before relying on it.
// Type: reference snippet / extension
// Context: SAP standard reference
