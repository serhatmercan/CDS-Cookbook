// ============================================================================
// Type       : complete CDS (view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_
// Module     :
// Business Object :
// ----------------------------------------------------------------------------
// Description
//
// Privacy / scope note
//   Scope the value help with a WHERE clause - an unrestricted F4 over a large
//   or personal-data table is not a reusable default. Project only the
//   elements the F4 needs.
//
// Common Use Cases
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// #NOT_REQUIRED states that no CDS access control is applied. It is not a
// protection statement. If the data needs protecting, use #CHECK together with
// a DCL role - #CHECK without an applicable role protects nothing.

@EndUserText.label: ' Value Help'

@Search.searchable: true

define view entity ZSM_I_
  as select from

{
      @ObjectModel.text.element: [ '' ]
      @Search.defaultSearchElement: true
  key ,

      @Search.defaultSearchElement: true
      @Semantics.text: true

}

where
