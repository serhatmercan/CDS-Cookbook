CDS         :   I_MaturityProfileCashFlow
Definition  :   Maturity Profile Cash Flow Data - Cube

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

Group       :   