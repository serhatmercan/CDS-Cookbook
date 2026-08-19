// ============================================================================
// Type       : complete CDS (root view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_VALUATION_TYPE_VH
// Module     : MM
// Business Object : Material Valuation Type
// ----------------------------------------------------------------------------
// Description
//   Value help listing material / valuation-area / valuation-type
//   combinations from the material valuation master (MBEW), with fuzzy search
//   on the valuation type and a plant value help on the valuation area.
//
// Patterns demonstrated
//   - multi-element key value help (the F4 is plant-dependent, so the
//     valuation area is part of the key)
//   - @Search.fuzzinessThreshold / @Search.ranking on a searchable element
//   - a nested @Consumption.valueHelpDefinition inside a value help
//
// Scope note
//   Records flagged for deletion are excluded. MBEW is a large master-data
//   table: always let the consumer bind the plant (see the consumption
//   snippet) so the F4 is filtered rather than fully scanned.
//
// See also
//   Custom/ValueHelp/ValueHelp-Consumption.abap - how a consuming element
//   declares this value help with an additionalBinding on the plant. That
//   snippet used to sit at the end of this file, where it was neither part of
//   this view entity nor separately usable.
//
// Common Use Cases
//   - F4 value help for a valuation type field, plant-dependent
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: no CDS access control is applied here. Valuation
// master data is usually not restricted at F4 level; if your application
// needs it, use #CHECK together with a DCL role.

@EndUserText.label: 'Valuation Type Value Help'

@Search.searchable: true

define root view entity ZSM_I_VALUATION_TYPE_VH
  as select from mbew

{
      @Search.defaultSearchElement: true
  key matnr as Matnr,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } } ]
      @Search.defaultSearchElement: true
  key bwkey as Bwkey,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key bwtar as Bwtar
}

where lvorm = ''
