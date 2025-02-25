CDS         :   I_BillingDocumentItemBasic
Description :   Billing Document Item Basic

Using       :   as select from I_BillingDocumentItemBasic as BillingDocumentItem  

Fields      :   key BillingDocumentItem.BillingDocument, 
                key BillingDocumentItem.BillingDocumentItem,    

                    @Semantics.amount.currencyCode: 'TransactionCurrency'
                    BillingDocumentItem.NetAmount,
  
                    @ObjectModel.foreignKey.association: 'TransactionCurrency'
                    @Semantics.currencyCode: true
                    BillingDocumentItem.TransactionCurrency

Where       :   

Group       :   