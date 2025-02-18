@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Maximum Begin / End Date in ZSM_T_001'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZSM_I_0001
  as select from ZSM_T_001
{
  key plate,
  max( begda ) as BeginDate,
  max( endda ) as EndDate
}
group by plate
