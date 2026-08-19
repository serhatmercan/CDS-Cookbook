// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension  :   (extend view <StandardView> with <ZAppendName>)
// Module     :
// Business Object :
// ----------------------------------------------------------------------------
// Description
//
// Fields Added
//
// Associations Used
//
// Common Use Cases
//
// Release note
//   Check that the target view is released for extension in your system, and
//   whether "extend view entity" applies instead of the classic append below.
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_'

@EndUserText.label: '<StandardView> Extend View'

extend view <StandardView> with ZSM_I_EXT_

// Declare additional associations here if the fields you need are not
// reachable through the extended view's own associations.

{
  // At least one element is required - an empty append does not activate.
}
