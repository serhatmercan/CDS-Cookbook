CDS         :   I_MaintOrderActualCostDataCube
Description :   Maintenance Order Actual Cost Data - Cube

Using       :   left outer join I_MaintOrderActualCostDataCube as Cost on Cost.MaintenanceOrder = I_MaintOrderTP.MaintenanceOrder

Fields      :   key Cost.SourceLedger,
                key Cost.CompanyCode,
                key Cost.FiscalYear,
                key Cost.AccountingDocument,
                key Cost.LedgerGLLineItem,
                key Cost.Ledger,

                    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
                    sum(Cost.AmountInCompanyCodeCurrency)                   as Expense,
                    Cost.CompanyCodeCurrency
Where       :   

Group By    :   

Module           :   PM
Business Object  :   Maintenance Order Actual Costs
Common Use Cases :   - Maintenance order actual cost analysis, embedded analytics cost cube
Notes            :   - Analytical cube view; aggregates actual cost line items by ledger/company code
Related CDS      :   I_MaintenanceOrderDEX, I_MaintOrderPlannedCostDataCube