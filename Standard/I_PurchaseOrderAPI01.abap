CDS         : I_PurchaseOrderAPI01  & I_PurchaseOrderItemAPI01  & I_PurchaseOrderHistoryAPI01  
Definition  : Purchase Order        & Purchase Order Item       & Purchase Order History  

Using       : as select from I_PurchaseOrderAPI01           as POHeader
                  inner join I_PurchaseOrderItemAPI01       as POItem           on POItem.PurchaseOrder     = POHeader.PurchaseOrder
                  inner join I_PurchaseOrderHistoryAPI01    as POHistory        on POHistory.PurchaseOrder  = POHeader.PurchaseOrder    " Optional    
              
              association [0..1] to I_MaterialText          as _MaterialText    on _MaterialText.Material   = $projection.Material
                                                                               and _MaterialText.Language   = $session.system_language
              association [0..1] to I_Supplier              as _Supplier        on _Supplier.Supplier       = $projection.Supplier

Fields      :   key POItem.PurchaseOrder,
                key POItem.PurchaseOrderItem,

                    " Purchase Order Header
                    POHeader.CompanyCode,
                    POHeader.CreatedByUser,
                    POHeader.CreationDate,
                    POHeader.DocumentCurrency,
                    POHeader.ExchangeRate,
                    POHeader.ExchangeRateIsFixed,
                    POHeader.IncotermsClassification,  
                    POHeader.Language, 
                    POHeader.PaymentTerms, 
                    POHeader.PricingDocument,
                    POHeader.PricingProcedure,
                    POHeader.PurchaseOrderDate,
                    POHeader.PurchaseOrderType,
                    POHeader.PurchaseOrderSubtype,
                    POHeader.PurchasingDocumentOrigin,
                    POHeader.PurchasingGroup,
                    POHeader.PurchasingOrganization,
                    POHeader.ReleaseCode,

                    POHeader.Supplier,
                    _Supplier.SupplierName                                          as SupplierName,

                    POHeader.SupplyingPlant,
                    
                    " Purchase Order Item
                    POItem.AccountAssignmentCategory,
                    POItem.BaseUnit,
                    POItem.GoodsReceiptIsExpected,
                    POItem.GrossAmount,                    
                    POItem.IncotermsClassification,
                    POItem.IncotermsLocation1,
                    POItem.IncotermsLocation2,
                    POItem.IncotermsTransferLocation,
                    POItem.InventorySpecialStockType,
                    POItem.InvoiceIsExpected,
                    POItem.InvoiceIsGoodsReceiptBased,
                    POItem.IsCompletelyDelivered,
                    POItem.IsReturnsItem,
                    POItem.ManufacturerMaterial,

                    POItem.Material,
                    _MaterialText.MaterialName                                      as MaterialName,

                    POItem.MaterialGroup,
                    POItem.MaterialType,
                    POItem.NetAmount,

                    @Semantics.amount.currencyCode: 'DocumentCurrency'
                    POItem.NetPriceAmount,

                    @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
                    POItem.OrderQuantity,
                    POItem.OrderPriceUnit,                    
                    POItem.PurchaseOrderQuantityUnit,

                    POItem.OrdPriceUnitToOrderUnitDnmntr,
                    POItem.OrderPriceUnitToOrderUnitNmrtr,
                    POItem.OverdelivTolrtdLmtRatioInPct,
                    POItem.Plant,
                    POItem.PlannedDeliveryDurationInDays,
                    POItem.PricingDateControl,
                    POItem.PurchaseContract,
                    POItem.PurchaseContractItem,
                    POItem.PurchasingDocumentDeletionCode,
                    POItem.PurchaseOrderCategory,
                    POItem.PurchaseRequisition,
                    POItem.PurchaseRequisitionItem,
                    POItem.PurchaseOrderItemText,
                    POItem.PurgDocPriceDate,
                    POItem.RequisitionerName,
                    POItem.StockType,
                    POItem.StorageLocation,
                    POItem.SupplierConfirmationControlKey,
                    POItem.UnderdelivTolrtdLmtRatioInPct,
                    POItem.UnlimitedOverdeliveryIsAllowed,
                    POItem.ValuationType,

                    " Purchase Order History
                    POHistory.AccountAssignmentNumber,          " Key
                    POHistory.AccountingDocumentCreationDate,
                    POHistory.CompanyCodeCurrency,
                    POHistory.Currency,
                    POHistory.DebitCreditCode,
                    POHistory.DeliveryDocument,
                    POHistory.DeliveryDocumentItem,
                    POHistory.DeliveryQuantityUnit,
                    POHistory.DocumentCurrency,
                    POHistory.DocumentDate,
                    POHistory.DocumentReferenceID,
                    POHistory.ExchangeRate,
                    POHistory.InventoryValuationType,
                    POHistory.Material,
                    POHistory.PostingDate,
                    POHistory.PurchasingHistoryCategory,
                    POHistory.PurchasingHistoryDocument,        " Key                                        
                    POHistory.PurchasingHistoryDocumentItem,    " Key
                    POHistory.PurchasingHistoryDocumentType,
                    POHistory.PurchasingHistoryDocumentYear,    " Key
                    POHistory.PurchaseOrderAmount,
                    POHistory.PurgHistDocumentCreationTime,

                    @Semantics.amount.currencyCode: 'Currency'
                    POHistory.PurchaseOrderAmount,

                    POHistory.PurOrdAmountInCompanyCodeCrcy,

                    @Semantics.quantity.unitOfMeasure:'PurchaseOrderQuantityUnit'
                    POHistory.Quantity,
                    POHistory.PurchaseOrderQuantityUnit,

                    POHistory.ReferenceDocument,
                    POHistory.ReferenceDocumentItem,
                    POHistory.TaxCode

Where       :   ( POHeader.PurchasingOrganization = '1100' or POHeader.PurchasingOrganization = '1200' ) and  
                POHeader.PurchaseOrderType             like 'YN%'  and  
                POItem.PurchasingDocumentDeletionCode     = ''     or
                ( POHistory.PurchasingHistoryDocumentType = '2' or POHistory.PurchasingHistoryDocumentType = '3' )

Group       : 