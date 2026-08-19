CDS         :   P_APJrnlEntrItmOpenPay
Description :   Accounts Payable Open Item (Open Payables as of Key Date)

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

Group By    :   
Module          :   FI-AP (Accounts Payable)
Business Object :   Open Accounts Payable Item (Journal Entry)
Common Use Cases:   Accounts payable open/overdue item analysis as of a given key date
Related CDS     :   P_APJrnlEntrItmOpenPay2
Release note     :   P_* views belong to the private/internal VDM layer. They are not
                     released reuse APIs: SAP may change or remove them. Treat this file as a
                     record of what was used, and prefer a released alternative if one exists.
Type             :   reference snippet
Context          :   SAP standard reference
