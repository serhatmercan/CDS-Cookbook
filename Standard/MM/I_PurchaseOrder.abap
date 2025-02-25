CDS         :   I_PurchaseOrder
Description :   Purchase Order

Using       :   as select from I_PurchaseOrder                  as PO       on PO.PurchaseOrder   = R_PurchasingDocumentItem.PurchasingDocument
                   association [0..1] to I_PurchaseOrderItem    as _POI     on _POI.PurchaseOrder = PO.PurchaseOrder

Fields      :   key _POI.PurchaseOrder,
                key _POI.PurchaseOrderItem,
                
                    PO.PurchasingGroup,

Where       :   

Group       :   