CDS         :   I_SalesDocument & I_SalesDocumentItem
Description :   Sales Document & Sales Document Item

Using       :   as select from I_SalesDocument              as SD             
                    inner join I_SalesDocumentItem          as SDI on SDI.SalesDocument = SD.SalesDocument

                association [0..1] to I_SalesDocumentItem   as _SalesQuoteFilter on _SalesQuoteFilter.ReferenceSDDocument     = $projection.SalesDocument
                                                                                and _SalesQuoteFilter.ReferenceSDDocumentItem = $projection.SalesDocumentItem

                association [0..1] to I_Supplier            as _Supplier         on _Supplier.Supplier                        = $projection.Supplier


Fields      :   key SDI.SalesDocument,
                key SDI.SalesDocumentItem,

                    " Sales Document
                    SD.AdditionalValueDays,
                    SD.CreationDate,
                    SD.CreationTime,
                    SD.CustomerGroup,
                    SD.CustomerPaymentTerms,
                    SD.DistributionChannel,
                    SD.OrganizationDivision,
                    SD.OverallSDDocumentRejectionSts,
                    SD.PricingDate,
                    SD.SalesDocumentCondition,
                    SD.SalesDocumentType,
                    SD.SalesGroup,
                    SD.SalesOrganization,
                    SD.SalesOffice,
                    SD.SDDocumentCategory,
                    SD.SDPricingProcedure,

                    SD.SoldToParty                               as Supplier,
                    _SupplierName.SupplierName                   as SupplierName,

                    SD.StatisticsCurrency,
                    SD.TotalBlockStatus,

                    " Sales Document Item
                    SDI.IncotermsClassification,
                    SDI.IsReturnsItem,

                    SDI.Material,
                    SDI._MaterialText[Material = $projection.Material and Language = $session.system_language ].MaterialName,

                    @Semantics.amount.currencyCode: 'TransactionCurrency'
                    SDI.NetAmount,
                    SDI.TransactionCurrency,

                    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
                    SDI.OrderQuantity,
                    SDI.OrderQuantityUnit,
                    
                    SDI.Plant,
                    SDI.SalesDocumentCondition                   as SalesDocumentConditionI,
                    SDI.SalesDocumentItemText,
                    SDI.SalesDocumentRjcnReason,
                    SDI.SalesGroup                               as SalesGroupI,
                    SDI.SalesOffice                              as SalesOfficeI,
                    SDI.SDProcessStatus,
                    SDI.StorageLocation,
                    
                    SDI._Material.MaterialType,

                    _SalesQuoteFilter

Where       :   SD.SDDocumentCategory       =  'B' and
                SDI.SalesDocumentRjcnReason =  ''  and 
                _SalesQuoteFilter.SalesDocument is null

Group       : 