CDS         :   R_PurchasingDocumentItem
Definition  :   Purchasing Document Item

Using       :   as select from R_PurchasingDocumentItem as RDI " on RDI.PurchasingDocument = I_PurchaseOrder.PurchaseOrder

Fields      :   key RDI.PurchasingDocument,
                key RDI.PurchasingDocumentItem,

                    RDI.PurchaseOrderCategory,
                    RDI.PurchasingDocumentItemUniqueID
                    

Where       :   

Group       :   