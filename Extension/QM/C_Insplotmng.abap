// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension  : C_Insplotmng  (extend view ... with ZSM_I_EXT_IM)
// Module     : QM
// Business Object : Inspection Lot Management
// ----------------------------------------------------------------------------
// Description
//   Propagates the status elements added one layer below (by the
//   I_InspectionLot extension) up into the Inspection Lot Management
//   consumption view.
//
// Fields Added
//   UsageDecisionStatus - active user status code, from the I_InspectionLot extension
//   UdSkippedText       - status short text, from the I_InspectionLot extension
//   UdRequiredText      - status short text, from the I_InspectionLot extension
//
// Pattern demonstrated
//   - propagating fields added by a lower-layer extension through a
//     consumption view; the element names must match the names the lower
//     extension introduced
//
// Related
//   Extension/QM/I_InspectionLot.abap - the extension that adds these elements
//
// Common Use Cases
//   - Inspection lot management UI: show the usage-decision status as text
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_IM'

@EndUserText.label: 'C_Insplotmng Extend View'

extend view C_Insplotmng with ZSM_I_EXT_IM

{
  UsageDecisionStatus,
  UdSkippedText,
  UdRequiredText
}
