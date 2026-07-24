@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_TOF_VH'

@EndUserText.label: 'C_TechObjFlatVH Extend View'

extend view C_TechObjFlatVH with ZSM_I_EXT_TOF_VH

  association [1] to ZPM_I_0001 as I0001
    on  I0001.bname = $session.user
    and (   I0001.TopTplnr = $projection.SuperiorTechnicalObject
         or (I0001.TopTplnr = $projection.TechnicalObject and $projection.SuperiorTechnicalObject = ''))

  association [1] to ZPM_I_0002 as I0002
    on I0002.TechnicalObject = $projection.SuperiorTechnicalObject

{
  @UI.hidden: true
  I0001.werks,

  @Consumption.valueHelpDefinition: [ { entity: { name: 'C_TechObjFlatVH', element: 'TechnicalObject' },
                                        additionalBinding: [ { element: 'TechObjIsEquipOrFuncnlLoc',
                                                               localConstant: 'EAMS_FL',
                                                               usage: #FILTER } ] } ]
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #MEDIUM
  cast(I0002.TechnicalObject as char40) as SuperiorTechnicalObject2,

  I0002
}
