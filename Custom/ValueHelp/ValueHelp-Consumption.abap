// ============================================================================
// Type       : reference snippet (annotation fragment - not activatable alone)
// Context    : reusable pattern
// Module     : cross-application
// Business Object : any
// ----------------------------------------------------------------------------
// Description
//   How a consuming element declares a value help, including the two
//   annotation options that most often get missed:
//
//     additionalBinding - passes a second field from the consuming view into
//                         the value help, so a plant-dependent F4 is filtered
//                         by the plant already selected on the screen instead
//                         of listing every combination.
//                         element      = the element in the VALUE HELP entity
//                         localElement = the element in THIS entity
//                         usage        = #FILTER restricts the F4 result,
//                                        #RESULT copies the value back
//                         localConstant is used instead of localElement when
//                         the bound value is fixed.
//
//     distinctValues    - suppresses duplicate rows when the value help entity
//                         has a wider key than the element being helped.
//
// Paste the annotation block above the element it belongs to, inside your own
// view's element list. It is a fragment: on its own it is not an activatable
// object.
//
// Related
//   Custom/ValueHelp/ZSM_I_VALUATION_TYPE_VH.abap - the value help used below
// ============================================================================

//  ... inside the element list of a consuming CDS view ...

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSM_I_VALUATION_TYPE_VH', element: 'Bwtar' },
                                            additionalBinding: [ { element:      'Bwkey',
                                                                   localElement: 'Plant',
                                                                   usage:        #FILTER } ],
                                            distinctValues: true } ]
      @Search.defaultSearchElement: true
      @UI: { identification: [ { position: 60 } ],
             lineItem:       [ { position: 60, importance: #HIGH } ],
             selectionField: [ { position: 70 } ] }
  key ValuationType : bwtar;
