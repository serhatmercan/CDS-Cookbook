@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Measurement Unit Value Help'
@Search.searchable: true

define root view entity ZSM_I_MEASUREMENT_UNIT_VH
  as select from matdocoil_index    as MI
    left outer join t006            as T1 on T1.msehi = MI.msehi
    left outer join t006a           as T2 on T2.msehi = MI.msehi
                                         and T2.spras = $session.system_language
    left outer join t006d           as T3 on T3.dimid = T1.dimid
    left outer join t006t           as T4 on T4.dimid = T3.dimid
                                         and T4.spras = $session.system_language

{
  key MI.msehi as Msehi,

      T2.mseh3 as Mseh3,
      T2.msehl as Msehl,
      T4.txdim as Txdim
}
where T1.kzex3 = 'X'
