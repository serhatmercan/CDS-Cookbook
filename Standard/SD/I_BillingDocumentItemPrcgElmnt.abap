CDS         :   I_BillingDocumentItemPrcgElmnt
Definition  :   Billing Document Item Pricing Element

Using       :   as select from  I_BillingDocumentItemPrcgElmnt as Pricing

                left outer join I_ProductText                  as ProductText on ProductText.Product  = $projection.Product
                                                                             and ProductText.Language = 'T'

Fields      :   key Pricing.BillingDocument,
                key Pricing.BillingDocumentItem,
                key Pricing.PricingProcedureStep,
                key Pricing.PricingProcedureCounter,

                " Pricing
                @Semantics.amount.currencyCode: 'TransactionCurrency'
                Pricing.ConditionAmount,

                Pricing.ConditionRateValue,
                Pricing.ConditionType,
                Pricing.ConditionQuantity,
                Pricing.ConditionQuantityUnit,
                Pricing.TransactionCurrency, 

                " Pricing -> Biling Document
                Pricing._BillingDocument.CompanyCode,

                " Pricing -> Item
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
                _ProductText.ProductName, 

                " Pricing -> Item -> Bill To Party
                Pricing._Item._BillToParty.Customer,
                Pricing._Item._BillToParty.CustomerName,
                Pricing._Item._BillToParty.TaxNumber2,

                " Pricing -> Item -> Product
                Pricing._Item._Product.ExternalProductGroup,
                Pricing._Item._Product.ProductHierarchy, 

                " Pricing -> Item -> Reference Delivery Document Item
                Pricing._Item._ReferenceDeliveryDocumentItem.InventoryValuationType

Where       :   Pricing.ConditionType                               =  'EXD1'   and
                Pricing._BillingDocument.AccountingTransferStatus   =  'C'      and  
                Pricing._BillingDocument.BillingDocumentIsTemporary =  ''       and  
                Pricing._BillingDocument.BillingDocumentIsCancelled =  ''       and 
                Pricing._BillingDocument.CompanyCode                =  '1000'   and
                Pricing._BillingDocument.SDDocumentCategory         =  'M'      and 
                ( Pricing._Item._ReferenceDeliveryDocumentItem.InventoryValuationType = 'PROC_TA_IM' or Pricing._Item._ReferenceDeliveryDocumentItem.InventoryValuationType = 'PROD_TA' )

Group       :   