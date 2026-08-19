CDS         :   I_SalesDocument & I_SalesDocumentItem
Description :   Sales Document & Sales Document Item

Module           :   SD
Business Object  :   Sales Document (Quotation - SDDocumentCategory 'B')

Using       :   as select from I_SalesDocument                      as SD
                    inner join I_SalesDocumentItem                  as SDI on SDI.SalesDocument = SD.SalesDocument

                association [0..1] to I_SalesDocumentItem           as _SalesQuoteFilter on _SalesQuoteFilter.ReferenceSDDocument       = $projection.SalesDocument
                                                                                        and _SalesQuoteFilter.ReferenceSDDocumentItem   = $projection.SalesDocumentItem

                association [0..*] to I_SalesDocumentItemPartner    as _SDIPartner       on _SDIPartner.SalesDocument                   = $projection.SalesDocument
                                                                                        and _SDIPartner.SalesDocumentItem               = $projection.SalesDocumentItem

                association [0..1] to I_Customer                    as _SoldToParty      on _SoldToParty.Customer                       = $projection.SoldToParty

Fields      :   key SDI.SalesDocument,
                key SDI.SalesDocumentItem,

                    // Sales Document
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

                    SD.SoldToParty,
                    _SoldToParty.CustomerName                    as SoldToPartyName,

                    SD.StatisticsCurrency,
                    SD.TotalBlockStatus,

                    // Sales Document Item
                    SDI.IncotermsClassification,
                    SDI.IsReturnsItem,

                    SDI.Material,
                    SDI._MaterialText[1: Language = $session.system_language ].MaterialName,

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

                    _SalesQuoteFilter,
                    _SDIPartner

Associations Used:   _SalesQuoteFilter (self, to exclude quotations already copied to a follow-on doc), _SDIPartner, _SoldToParty, _MaterialText

Where       :   SD.SDDocumentCategory       =  'B' and
                SDI.SalesDocumentRjcnReason =  ''  and
                _SalesQuoteFilter.SalesDocument is null

Group By    :

Common Use Cases :   - Open sales quotation reporting, excluding quotations already referenced by a subsequent document

Related CDS      :   I_SalesOrder, I_SalesDocumentScheduleLine, I_BillingDocument

Notes            :   - _SalesQuoteFilter anti-join (is null) is what excludes already-referenced quotation items
                     - A sold-to party is a customer: it is resolved through I_Customer, not
                     I_Supplier. Aliasing SoldToParty as "Supplier" and joining a supplier
                     view returns nothing meaningful.
                     - The material text is read with a filtered path that carries a
                     cardinality prefix - [1: ... ] - because the text association is
                     to-many; without the prefix a to-many text join multiplies rows.
Type             :   reference snippet
Context          :   SAP standard reference
