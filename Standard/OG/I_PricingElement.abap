CDS         :   I_PricingElement
Description :   Pricing Element

Using       :   inner join I_PricingElement as PE on PE.PricingDocument = I_PurchaseOrderAPI01.PricingDocument
                                                 and PE.ConditionType   = $parameters.p_condition_type   // configuration - pass it in
                                                 and PE.ConditionAmount > 0

Fields      :   key PE.PricingDocument,
                key PE.PricingDocumentItem,
                key PE.PricingProcedureStep,
                key PE.PricingProcedureCounter,

                    @Semantics.amount.currencyCode: 'TransactionCurrency'
                    PE.ConditionAmount,

                    PE.ConditionType,
                    PE.TransactionCurrency

Where       :   

Group By    :   

Module           :   SD / MM (Pricing)
Business Object  :   Pricing Document Condition
Common Use Cases :   - Retrieve a specific condition amount (freight/service surcharge) linked to a
                   purchase order's pricing document
Notes            :   - The condition type is passed as a parameter instead of hard-coded: a
                     specific condition type is always installation configuration.
