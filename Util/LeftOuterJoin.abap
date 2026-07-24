@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Vehicle Information'

define root view entity ZSD_I_0001
  as select from    oigv

    left outer join oigvt
      on  oigvt.vehicle  = oigv.vehicle
      and oigvt.language = $session.system_language

    left outer join zsm_i_0001 as i0001
      on i0001.plate = oigv.vehicle

    left outer join vbrk
      on  vbrk.vbeln  = oigv.vehicle
      and vbrk.fksto != 'X'

{
  key oigv.vehicle,

      oigvt.veh_text,
      i0001.begda,
      i0001.endda
}
