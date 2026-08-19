// ============================================================================
// Type       : complete CDS (root view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_MEASUREMENT_UNIT_VH
// Module     : MM (IS-OIL relevant selection)
// Business Object : Unit of Measure
// ----------------------------------------------------------------------------
// Description
//   Value help for units of measure, restricted to units flagged for the
//   IS-OIL three-decimal quantity exchange (T006-KZEX3), with the
//   language-dependent unit texts and the dimension text.
//
// Source note
//   The unit master (T006) is the source, not a material-document index.
//   An earlier revision read MATDOCOIL_INDEX, a large transactional index
//   table: that produced one candidate row per document line, so the key was
//   not unique and the value help returned duplicates while scanning far more
//   data than a master-data F4 needs.
//
// Patterns demonstrated
//   - master-data value help with language-dependent texts resolved through
//     $session.system_language
//   - dimension text joined one level further out (T006D/T006T)
//   - a genuinely unique key for a value help
//
// Common Use Cases
//   - F4 value help for oil-quantity unit-of-measure fields
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: unit-of-measure configuration is not sensitive, so no
// CDS access control is applied. #NOT_REQUIRED states that, it does not
// protect anything.

@EndUserText.label: 'Measurement Unit Value Help'

@Search.searchable: true

define root view entity ZSM_I_MEASUREMENT_UNIT_VH
  as select from    t006  as Unit

    left outer join t006a as UnitText
      on  UnitText.mandt = Unit.mandt
      and UnitText.msehi = Unit.msehi
      and UnitText.spras = $session.system_language

    left outer join t006d as Dimension
      on Dimension.dimid = Unit.dimid

    left outer join t006t as DimensionText
      on  DimensionText.dimid = Dimension.dimid
      and DimensionText.spras = $session.system_language

{
      @Search.defaultSearchElement: true
  key Unit.msehi            as Msehi,

      UnitText.mseh3        as Mseh3,

      @Search.defaultSearchElement: true
      @Semantics.text: true
      UnitText.msehl        as Msehl,

      Unit.dimid            as Dimid,
      DimensionText.txdim   as Txdim
}

// KZEX3 marks units used with three decimal places in the IS-OIL quantity
// conversion - a standard industry-solution flag, not customer configuration.
where Unit.kzex3 = 'X'
