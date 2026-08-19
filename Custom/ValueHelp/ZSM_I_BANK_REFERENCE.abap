// ============================================================================
// Type       : complete CDS (view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_BANK_REFERENCE  (value help view)
// Module      : FI
// Business Object : Currency
// ----------------------------------------------------------------------------
// Description
//   Value help listing currency codes with their long/short texts (TCURC/TCURT),
//   cast to the data element of the consuming field.
//
// Modelling note
//   The CAST is the point of this recipe: the value help delivers a currency
//   code, but the consuming field is typed with its own data element, so the
//   element is cast to that type to keep the F4 binding type-compatible. Replace
//   BKREF with your own data element. A value help also needs a key element -
//   without one, consumers cannot bind to it.
//
// Associations Used   (none)
//
// Common Use Cases
//   - F4 value help for a custom "Bank Reference" field typed on the BKREF domain
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Bank Reference Value Help'

@Search.searchable: true

define view entity ZSM_I_BANK_REFERENCE
  as select from tcurc as T1

    inner join   tcurt as T2
      on  T2.waers = T1.waers
      and T2.spras = $session.system_language

{
      @ObjectModel.text.element: [ 'BankReferenceLongText' ]
      @Search.defaultSearchElement: true
  key cast(T2.waers as bkref) as BankReference,

      @Semantics.text: true
      T2.ltext                as BankReferenceLongText,
      T2.ktext                as BankReferenceShortText
}
