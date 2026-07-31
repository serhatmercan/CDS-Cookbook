CDS         :   I_PricingElement
Description :   Pricing Element

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

Module           :   SD / MM (Pricing)
Business Object  :   Pricing Document Condition
Common Use Cases :   - Retrieve a specific condition amount (freight/service surcharge) linked to a
                   purchase order's pricing document
Notes            :   - Filtered to ConditionType 'CFO1' with ConditionAmount > 0 - client-specific
                   condition type
