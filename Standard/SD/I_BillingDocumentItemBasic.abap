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

Module           :   SD
Business Object  :   Billing Document Item
Common Use Cases :   - Lightweight lookup of billing item net amount / currency without pulling the full item view
Related CDS      :   I_BillingDocument, I_BillingDocumentItemPrcgElmnt