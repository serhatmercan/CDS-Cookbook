// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : genericised enterprise pattern
// Extension   : C_TechObjFlatVH  (extend view ... with ZSM_I_EXT_TOF_VH)
// Module      : PM
// Business Object : Technical Object (Value Help)
// ----------------------------------------------------------------------------
// Description
//   Restricts/enriches the flat Technical Object value help by resolving the
//   current user's authorized plant (via ZPM_I_0001) and exposing a superior
//   technical object as a searchable char40 field with its own value help.
//
// Fields Added
//   werks (hidden)             - I0001.werks, plant of current user, used for filtering
//   SuperiorTechnicalObject2   - cast(I0002.TechnicalObject as char40), searchable, own F4 help
//   I0002                      - included association (all fields of ZPM_I_0002)
//
// Associations Used
//   I0001 -> ZPM_I_0001   on bname = $session.user and (TopTplnr = SuperiorTechnicalObject
//                            or (TopTplnr = TechnicalObject and SuperiorTechnicalObject = ''))
//   I0002 -> ZPM_I_0002   on TechnicalObject = SuperiorTechnicalObject
//
// Common Use Cases
//   - F4 value help for Technical Object fields, scoped to the user's plant
//     via custom ZPM_I_0001 authorization/assignment view
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_TOF_VH'

@EndUserText.label: 'C_TechObjFlatVH Extend View'

extend view C_TechObjFlatVH with ZSM_I_EXT_TOF_VH

  association [0..*] to ZPM_I_0001 as I0001
    on  I0001.bname = $session.user
    and (   I0001.TopTplnr = $projection.SuperiorTechnicalObject
         or (I0001.TopTplnr = $projection.TechnicalObject and $projection.SuperiorTechnicalObject = ''))

  association [0..1] to ZPM_I_0002 as I0002
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
