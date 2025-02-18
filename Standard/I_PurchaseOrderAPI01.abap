CDS         : I_PurchaseOrderAPI01 & I_PurchaseOrderItemAPI01
Definition  : Purchase Order

Using       : as select from I_PurchaseOrderAPI01       as POHeader
                  inner join I_PurchaseOrderItemAPI01   as POItem    on POItem.PurchaseOrder   = POHeader.PurchaseOrder
              
              association [0..1] to I_MaterialText  as _MaterialText on _MaterialText.Material = $projection.Material
                                                                    and _MaterialText.Language = $session.system_language
              association [0..1] to I_Supplier      as _Supplier     on _Supplier.Supplier     = $projection.Supplier

Fields      :   key POItem.PurchaseOrder,
                key POItem.PurchaseOrderItem,
                    
                    POItem.BaseUnit,
                    POHeader.CompanyCode,
                    POHeader.DocumentCurrency,
                    POHeader.IncotermsClassification,
                    POItem.ManufacturerMaterial,

                    POItem.Material,
                    _MaterialText.MaterialName                                      as MaterialName,

                    POItem.MaterialGroup,
                    POItem.MaterialType,

                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    POItem.NetPriceAmount,

                    @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
                    POItem.OrderQuantity,
                    POItem.OrderPriceUnit,
                    POItem.PurchaseOrderQuantityUnit,

                    POHeader.PaymentTerms,
                    POItem.Plant,
                    POHeader.PricingDocument,
                    POHeader.PricingProcedure,
                    POHeader.PurchaseOrderType,
                    POHeader.PurchasingGroup,
                    POItem.PurchaseOrderItemText,
                    POHeader.PurchasingOrganization,
                    POItem.StorageLocation,

                    POHeader.Supplier,
                    _Supplier.SupplierName                                          as SupplierName

Where       : ( POHeader.PurchasingOrganization = '1100' or POHeader.PurchasingOrganization = '1200' ) and  
                POHeader.PurchaseOrderType like 'YN%' and  
                POItem.PurchasingDocumentDeletionCode = ''

Group       : 