CDS         :   P_APJrnlEntrItmOpenPay
Description :   

Using       :   as select from P_APJrnlEntrItmOpenPay2(P_KeyDate : P_KeyDate) as OpenPay  

Fields      :   key OpenPay.CompanyCode,
                key OpenPay.FiscalYear,
                key OpenPay.AccountingDocument,
                key OpenPay.LedgerGLLineItem,   

                OpenPay.AccountingDocumentItem,
                OpenPay.AmountInCompanyCodeCurrency,
                OpenPay.AssignmentReference,
                OpenPay.BusinessArea,
                OpenPay.ClearingDate,
                OpenPay.CompanyCodeCurrency,
                OpenPay.CostCenter,
                OpenPay.DocumentDate,
                OpenPay.FinancialAccountType,
                OpenPay.FollowOnDocumentType,
                OpenPay.FunctionalArea,
                OpenPay.GLAccount,
                OpenPay.InvoiceItemReference,
                OpenPay.InvoiceReference,
                OpenPay.InvoiceReferenceFiscalYear,
                OpenPay.NetDueDate,
                OpenPay.PostingDate,
                OpenPay.ProfitCenter,
                OpenPay.PurchasingDocument,
                OpenPay.RefInvcDebitCreditCode,
                OpenPay.RefInvcDocumentDate,
                OpenPay.RefInvcFinancialAccountType,
                OpenPay.RefInvcInvoiceReference,
                OpenPay.RefInvcNetDueDate,
                OpenPay.RefInvcNetPaymentDays,
                OpenPay.Segment,
                OpenPay.SpecialGLCode,
                OpenPay.SupplierOpenPay             

Where       :   

Group       :   
Module          :   FI-AP (Accounts Payable)
Business Object :   Open Accounts Payable Item (Journal Entry)
Common Use Cases:   Accounts payable open/overdue item analysis as of a given key date
Related CDS     :   P_APJrnlEntrItmOpenPay2