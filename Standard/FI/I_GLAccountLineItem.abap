CDS         :   I_GLAccountLineItem
Definition  :   General Ledger Account Line Item

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
                    GLALItemAmountInCompanyCodeCurrency

                    GLALItem.BusinessArea,
                    GLALItem.ChartOfAccounts,
                    GLALItem.CompanyCodeCurrency,
                    GLALItem.ControllingArea,
                    GLALItem.DocumentItemText,
                    GLALItem.FiscalPeriod,
                    
                    GLALItem.GLAccount,
                    GLAccountText.GLAccountName

Where       :   GLALItemSourceLedger = GLALItemLedger

Group       :   