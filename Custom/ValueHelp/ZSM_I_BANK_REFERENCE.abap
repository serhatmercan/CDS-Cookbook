@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bank Reference Value Help'
@Search.searchable: true

define view entity ZSM_I_BANK_REFERENCE 
    as select from tcurc as T1
        inner join tcurt as T2 on T2.waers = T1.waers
                              and T2.spras = 'T'
{
    cast( T2.waers as bkref ) as BankReference,
    T2.ltext                  as BankReferenceLongText,
    T2.ktext                  as BankReferenceShortText      
}
