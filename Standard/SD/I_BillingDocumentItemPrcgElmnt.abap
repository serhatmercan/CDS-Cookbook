CDS         :   I_BillingDocumentItemPrcgElmnt
Description :   Billing Document Item Pricing Element

Module           :   SD
Business Object  :   Billing Document Pricing Element

Using       :   as select from  I_BillingDocumentItemPrcgElmnt as Pricing

                left outer join I_ProductText                  as ProductText on ProductText.Product  = $projection.Product
                                                                             and ProductText.Language = $session.system_language

Fields      :   key Pricing.BillingDocument,
                key Pricing.BillingDocumentItem,
                key Pricing.PricingProcedureStep,
                key Pricing.PricingProcedureCounter,

                // Pricing
                @Semantics.amount.currencyCode: 'TransactionCurrency'
                Pricing.ConditionAmount,

                Pricing.ConditionRateValue,
                Pricing.ConditionType,
                Pricing.ConditionQuantity,
                Pricing.ConditionQuantityUnit,
                Pricing.TransactionCurrency,

                // Pricing -> Biling Document
                Pricing._BillingDocument.CompanyCode,

                // Pricing -> Item
                @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
                Pricing._Item.BillingQuantity,
                Pricing._Item.BillingQuantityUnit,

                @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
                Pricing._Item.ItemNetWeight,
                Pricing._Item.ItemWeightUnit,

                @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
                Pricing._Item.ItemVolume,
                Pricing._Item.ItemVolumeUnit,

                Pricing._Item.Plant,

                Pricing._Item.Product,
                ProductText.ProductName,

                // Pricing -> Item -> Bill To Party
                Pricing._Item._BillToParty.Customer,
                Pricing._Item._BillToParty.CustomerName,
                Pricing._Item._BillToParty.TaxNumber2,

                // Pricing -> Item -> Product
                Pricing._Item._Product.ExternalProductGroup,
                Pricing._Item._Product.ProductHierarchy,

                // Pricing -> Item -> Reference Delivery Document Item
                Pricing._Item._ReferenceDeliveryDocumentItem.InventoryValuationType

Associations Used:   _BillingDocument, _Item, _BillToParty, _Product, _ReferenceDeliveryDocumentItem

Where       :   Pricing._BillingDocument.AccountingTransferStatus   =  'C'  and
                Pricing._BillingDocument.BillingDocumentIsTemporary =  ''   and
                Pricing._BillingDocument.BillingDocumentIsCancelled =  ''   and
                Pricing._BillingDocument.SDDocumentCategory         =  'M'
                // Condition type, company code and valuation types are configuration.
                // Add your own scope, e.g.:
                //   and Pricing.ConditionType = '...'
                //   and Pricing._BillingDocument.CompanyCode in ( ... )
                //   and Pricing._Item._ReferenceDeliveryDocumentItem.InventoryValuationType in ( ... )

Group By    :

Common Use Cases :   - Extract a specific pricing condition (e.g. excise/tax) amount per billing item

Related CDS      :   I_BillingDocument, I_BillingDocumentItemBasic

Notes            :   - Condition type, company code and valuation-type scope are configuration and
                     are intentionally not hard-coded. Add them for your own installation.
