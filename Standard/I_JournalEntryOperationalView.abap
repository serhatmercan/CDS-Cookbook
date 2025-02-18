CDS         : I_JournalEntryOperationalView
Definition  : Operational View on Journal Entry Item
Using       : I_JournalEntryOperationalView as _JEOV on _JEOV.CompanyCode          = Bkpf.bukrs
                                                    and _JEOV.AccountingDocument   = Bkpf.belnr
                                                    and _JEOV.FiscalYear           = Bkpf.gjahr
                                                    and _JEOV.FinancialAccountType = 'D'
Fields      : 