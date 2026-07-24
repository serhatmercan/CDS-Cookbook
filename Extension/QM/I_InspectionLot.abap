@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_'

@EndUserText.label: 'I_InspectionLot Extend View'

extend view I_InspectionLot with ZSM_I_EXT_IL

  association [1] to _Jest
    on  _Jest.Objnr = $projection.StatusObject
    and _Jest.Inact = ''

  association [0..1] to _Text
    on  _Text.Stsma = $projection.StatusProfile
    and Spras       = 'T'
    and (_Text.Estat = 'E0001' or _Text.Estat = 'E0002')

{
  _Text.txt04 as Txt04
}
