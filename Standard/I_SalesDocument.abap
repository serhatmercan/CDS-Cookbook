CDS         : I_SalesDocument & I_SalesDocumentItem
Definition  : Sales Document

Using       : as select from I_SalesDocument     as SD             
                  inner join I_SalesDocumentItem as SDI on SDI.SalesDocument = SD.SalesDocument

              association [0..1] to I_SalesDocumentItem as _SalesQuoteFilter on _SalesQuoteFilter.ReferenceSDDocument     = $projection.SalesDocument
                                                                            and _SalesQuoteFilter.ReferenceSDDocumentItem = $projection.SalesDocumentItem

              association [0..1] to I_Supplier          as _Supplier         on _Supplier.Supplier                        = $projection.Supplier


Fields      :   key SDI.SalesDocument,
                key SDI.SalesDocumentItem,

                    SD.AdditionalValueDays,
                    SD.CreationDate,
                    SD.CreationTime,
                    SD.CustomerGroup,
                    SD.CustomerPaymentTerms,
                    SD.DistributionChannel,
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

                    SD.OrganizationDivision,
                    SD.OverallSDDocumentRejectionSts,
                    SDI.Plant,
                    SD.PricingDate,
                    SD.SalesDocumentCondition,
                    SDI.SalesDocumentCondition                   as SalesDocumentConditionI,
                    SDI.SalesDocumentItemText,
                    SDI.SalesDocumentRjcnReason,
                    SD.SalesDocumentType,
                    SD.SalesGroup,
                    SDI.SalesGroup                               as SalesGroupI,
                    SD.SalesOrganization,
                    SD.SalesOffice,
                    SDI.SalesOffice                              as SalesOfficeI,
                    SD.SDDocumentCategory,
                    SD.SDPricingProcedure,
                    SDI.SDProcessStatus,

                    SD.SoldToParty                               as Supplier,
                    _SupplierName.SupplierName                   as SupplierName,

                    SD.StatisticsCurrency,
                    SDI.StorageLocation,
                    SD.TotalBlockStatus,

                    SDI._Material.MaterialType,

                    _SalesQuoteFilter

Where       :   SD.SDDocumentCategory       =  'B' and
                SDI.SalesDocumentRjcnReason =  ''  and 
                _SalesQuoteFilter.SalesDocument is null

Group       : 