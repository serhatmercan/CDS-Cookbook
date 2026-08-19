CDS         :   I_GLAccountLineItem
Description :   General Ledger Account Line Item

Using       :   as select from  I_GLAccountLineItem as GLALItem
                left outer join I_GLAccountText     as GLAText      on GLAText.ChartOfAccounts = GLALItem.ChartOfAccounts
                                                                   and GLAText.GLAccount       = GLALItem.GLAccount
                                                                   and GLAText.Language        = $session.system_language

Fields      :   key GLALItem.SourceLedger,
                key GLALItem.CompanyCode,
                key GLALItem.FiscalYear,
                key GLALItem.AccountingDocument,
                key GLALItem.LedgerGLLineItem,
                key GLALItem.Ledger,

                    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
                    GLALItem.AmountInCompanyCodeCurrency,

                    GLALItem.BusinessArea,
                    GLALItem.ChartOfAccounts,
                    GLALItem.CompanyCodeCurrency,
                    GLALItem.ControllingArea,
                    GLALItem.DocumentItemText,
                    GLALItem.FiscalPeriod,
                    
                    GLALItem.GLAccount,
                    GLAText.GLAccountName

Where       :   GLALItem.SourceLedger = GLALItem.Ledger

Group By    :   
Module          :   FI (Universal Journal / General Ledger)
Business Object :   G/L Account Line Item
Common Use Cases:   G/L line item reporting enriched with account description text (I_GLAccountText) in logon language
Notes           :   Where clause restricts to SourceLedger = Ledger, i.e. leading ledger lines only
Related CDS     :   I_GLAccountText, I_JournalEntryItem, I_OperationalAcctgDocItem
