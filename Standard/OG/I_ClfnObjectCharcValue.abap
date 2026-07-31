CDS         :   I_ClfnObjectCharcValue
Description :   Clfn Characteristic Value of Object

Using       :   inner join I_ClfnObjectCharcValue as COCV on COCV.ClfnObjectID       = VBRP.matnr
                                                         and COCV.ValidityStartDate <= I_BillingDocument.BillingDocumentDate
                                                         and COCV.ValidityEndDate   >= I_BillingDocument.BillingDocumentDate

Fields      :   key COCV.ClfnObjectID,
                key COCV.ClfnObjectTable,
                key COCV.CharcInternalID,
                key COCV.CharcValuePositionNumber,
                key COCV.ClfnObjectType,
                key COCV.ClassType,
                key COCV.TimeIntervalNumber,
                
                    COCV.CharcValue

Where       :   ( COCV.CharcValue != '' or COCV.CharcValue = 'A' or COCV.CharcValue = 'B' ) and
                COCV.ClassType          =  '001'    and
                COCV.ClfnObjectTable    =  'MARA'   and
                COCV.ClfnObjectType     =  'O'      

Group       :   

Module           :   CA (Classification System)
Business Object  :   Classification / Characteristic Value
Common Use Cases :   - Lookup classification characteristic values (e.g. commodity/tax codes) assigned
                   to a material for use in billing/pricing derivations
Notes            :   - ClfnObjectTable 'MARA' + ClassType '001' = material classification; validity dates
                   model time-dependent characteristic values
