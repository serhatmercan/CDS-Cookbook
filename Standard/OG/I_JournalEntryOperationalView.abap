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

Group By    :   

Module           :   FI
Business Object  :   Journal Entry / Accounting Document
Associations Used:   _OperationalAcctgDocItem -> operational accounting document item (bank details)
Common Use Cases :   - FI journal entry reporting joined to accounting document header (BKPF); vendor
                   payment / house bank enrichment
Notes            :   - Restricted to FinancialAccountType 'K' (vendor) on ledger L2
                   - Standard FI view; grouped here under OG because it was used to enrich an
                   Oil & Gas nomination/billing scenario in the source project, not because the
                   view itself is OG-specific
Related CDS      :   I_OperationalAcctgDocItem, I_JournalEntryItem
