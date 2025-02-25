CDS         :   I_JournalEntryOperationalView
Description :   Operational View on Journal Entry Item

Using       :   as select from I_JournalEntryOperationalView as JEOV on JEOV.AccountingDocument   = Bkpf.Belnr
                                                                    and JEOV.CompanyCode          = Bkpf.Bukrs
                                                                    and JEOV.FiscalYear           = Bkpf.Gjahr
                                                                    and JEOV.FinancialAccountType = 'D'
Fields      :   key JEOV.CompanyCode,
                key JEOV.FiscalYear,
                key JEOV.AccountingDocument,
                key JEOV.LedgerGLLineItem,

                    JEOV.AmountInBalanceTransacCrcy,
                    JEOV.AmountInCompanyCodeCurrency,

                    @Semantics.amount.currencyCode: 'TransactionCurrency'
                    JEOV.AmountInTransactionCurrency,
                    
                    JEOV.BalanceTransactionCurrency,
                    JEOV.ClearingCreationDate,
                    JEOV.ClearingJournalEntry,
                    JEOV.CompanyCodeCurrency,
                    JEOV.DocumentDate,
                    JEOV.HouseBank,
                    JEOV.HouseBankAccount,
                    JEOV.NetDueDate,
                    JEOV.PaymentMethod,
                    JEOV.PaymentMethodSupplement,
                    JEOV.PaymentTerms,
                    JEOV.PostingDate,
                    JEOV.Supplier,
                    JEOV.TransactionCurrency,
                    
                    JEOV._OperationalAcctgDocItem.BPBankAccountInternalID

Where       :   JEOV.AccountingDocumentType <> 'GM'  and
                JEOV.FinancialAccountType    = 'K'   and
                JEOV.Ledger                  = 'L2'  and
                JEOV.SourceLedger            = 'L2'  

Group       :   