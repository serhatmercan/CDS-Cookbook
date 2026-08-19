CDS         : I_PurchaseOrderAPI01  & I_PurchaseOrderItemAPI01  & I_PurchaseOrderHistoryAPI01   &  I_SuplrInvcItemPurOrdRefAPI01            & I_SupplierInvoiceAPI01   
Description : Purchase Order        & Purchase Order Item       & Purchase Order History        &  Purchase Order Ref of Supplier Invoice   & Supplier Invoice

Using       : as select from I_PurchaseOrderAPI01           as POHeader
                  inner join I_PurchaseOrderItemAPI01       as POItem           on POItem.PurchaseOrder             = POHeader.PurchaseOrder
                  left outer join I_PurchaseOrderHistoryAPI01 as POHistory   on POHistory.PurchaseOrder          = POHeader.PurchaseOrder        // optional - now LEFT OUTER
                  left outer join I_SuplrInvcItemPurOrdRefAPI01 as POReference on POReference.PurchaseOrder        = POItem.PurchaseOrder          // optional - now LEFT OUTER
                                                                               and POReference.PurchaseOrderItem    = POItem.PurchaseOrderItem
                  left outer join I_SupplierInvoiceAPI01      as SupplierInvoice on SupplierInvoice.SupplierInvoice  = POReference.SupplierInvoice   // optional - now LEFT OUTER
                                                                               and SupplierInvoice.FiscalYear       = POReference.FiscalYear                                                                                     
              
              association [0..1] to I_MaterialText          as _MaterialText    on _MaterialText.Material   = $projection.Material
                                                                               and _MaterialText.Language   = $session.system_language
              association [0..1] to I_Supplier              as _Supplier        on _Supplier.Supplier       = $projection.Supplier

Fields      :   key POItem.PurchaseOrder,
                key POItem.PurchaseOrderItem,

                    // Purchase Order Header
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
                    
                    // Purchase Order Item
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
                    POItem.PurchaseOrderItemCategory,
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

                    // Purchase Order History
                    POHistory.AccountAssignmentNumber,          // Key
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
                    POHistory.PurchasingHistoryDocument,        // Key                                        
                    POHistory.PurchasingHistoryDocumentItem,    // Key
                    POHistory.PurchasingHistoryDocumentType,
                    POHistory.PurchasingHistoryDocumentYear,    // Key
                    POHistory.PurgHistDocumentCreationTime,

                    @Semantics.amount.currencyCode: 'Currency'
                    POHistory.PurchaseOrderAmount,

                    POHistory.PurOrdAmountInCompanyCodeCrcy,

                    @Semantics.quantity.unitOfMeasure:'PurchaseOrderQuantityUnit'
                    POHistory.Quantity,
                    POHistory.PurchaseOrderQuantityUnit,

                    POHistory.ReferenceDocument,
                    POHistory.ReferenceDocumentItem,
                    POHistory.TaxCode,

                    // Purchase Order Ref of Supplier Invoice
                    POReference.PurchaseOrderQuantityUnit,
                    POReference.SupplierInvoiceItem,
                    POReference.SupplierInvoiceItemAmount,
                    POReference.QuantityInPurchaseOrderUnit,

                    // Supplier Invoice
                    SupplierInvoice.DocumentCurrency,
                    SupplierInvoice.DocumentDate,
                    SupplierInvoice.FiscalYear,
                    SupplierInvoice.PostingDate,
                    SupplierInvoice.SupplierInvoice,                    
                    SupplierInvoice.SupplierInvoiceIDByInvcgParty

Where       :   POItem.PurchasingDocumentDeletionCode = '' and
                POHistory.PurchasingHistoryDocumentType in ( '2', '3' )   // GR / IR history records
                // Organisational and document-type scope intentionally not hard-coded.
                // Add your own, e.g.:
                //   and POHeader.PurchasingOrganization in ( ... )
                //   and POHeader.PurchaseOrderType      in ( ... )
                //   and POItem.MaterialGroup            in ( ... )

Group By    :

Module           :   MM
Business Object  :   Purchase Order / Purchase Order History / Supplier Invoice
Common Use Cases :   - Three-way match style reporting: PO item, GR/IR history and referencing supplier invoice
                      - API-released (I_...API01) views, suitable for external/OData consumption
Notes            :   - Several joins marked "Optional" in the comments are still coded as inner join, which
                        will eliminate PO items without history/invoice reference - verify intent before reuse
                      - Where clause mixes and/or without full parentheses; standard AND-before-OR precedence
                        applies (evaluates as (...) and (...) and (...) or ((...) and (...))) - verify intent before reuse
Related CDS      :   I_PurchaseOrderItemAPI01, I_PurchaseOrderHistoryAPI01, I_SuplrInvcItemPurOrdRefAPI01, I_SupplierInvoiceAPI01
