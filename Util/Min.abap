@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Minimum'
define root view entity ZSM_I_0006
    as select from  vbrp
    inner join      oihl on oihl.licin = vbrp.oih_licin 
                        and oihl.lictp = vbrp.oih_lictp
{
  key v.vbeln                                                   as vbeln_vf,
      min(case when oihl.lictp = 'Z010' then vbrp.oidatto1 end) as amount
}
where
  v.draft is initial
group by
  v.vbeln
