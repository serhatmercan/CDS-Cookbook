CDS         :   I_MaturityProfileCashFlow
Description :   Maturity Profile Cash Flow Data - Cube

Using       :   as select from I_MaturityProfileCashFlow(   P_KeyDate                     : $parameters.P_KeyDate,
                                                            P_DisplayCurrency             : $parameters.P_DisplayCurrency,
                                                            P_ExchangeRateType            : $parameters.P_ExchangeRateType,
                                                            P_NmbrOfYearsOfTimeToMaturity : $parameters.P_NmbrOfYearsOfTimeToMaturity) as TransactionCashFlow

Fields      :   key TransactionCashFlow.CompanyCode,
                key TransactionCashFlow.FinancialTransaction,
                key TransactionCashFlow.SecurityAccount,
                key TransactionCashFlow.SecurityClass,
                key TransactionCashFlow.FixedVariableInterestRateCat,
                key TransactionCashFlow.TrsyCshFlowDebtInvmtCode,
                key TransactionCashFlow.PaymentDate,
                key TransactionCashFlow.ReferenceInterestRate,
                key TransactionCashFlow.InterestRateInPercent,
                
                    TransactionCashFlow.FinancialInstrProductCategory,
                    TransactionCashFlow.FinancialInstrumentProductType,
                    TransactionCashFlow.FinancialInstrTransactionType

Where       :   

Group By    :   
Module          :   FI-TRM (Treasury and Risk Management)
Business Object :   Treasury Cash Flow / Maturity Profile
Common Use Cases:   Treasury liquidity/maturity analysis - cash flow amounts by financial transaction and payment date bucket
Notes           :   Parameterized view - key date, display currency, exchange rate type and years-of-time-to-maturity must all be supplied
