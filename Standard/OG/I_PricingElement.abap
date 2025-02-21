CDS         :   I_PricingElement
Definition  :   Pricing Element

Using       :   inner join I_PricingElement as PE on PE.PricingDocument = I_PurchaseOrderAPI01.PricingDocument
                                                 and PE.ConditionType   = 'CFO1'
                                                 and PE.ConditionAmount > 0

Fields      :   key PE.PricingDocument,
                key PE.PricingDocumentItem,
                key PE.PricingProcedureStep,
                key PE.PricingProcedureCounter,

                    @Semantics.amount.currencyCode: 'TransactionCurrency'
                    PE.ConditionAmount,

                    ConditionType,
                    PE.TransactionCurrency

Where       :   

Group       :   