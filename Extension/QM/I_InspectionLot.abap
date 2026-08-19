// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension  : I_InspectionLot  (extend view ... with ZSM_I_EXT_IL)
// Module     : QM
// Business Object : Inspection Lot
// ----------------------------------------------------------------------------
// Description
//   Adds the active user status and its short text to the Inspection Lot
//   view, by associating the lot's status object to JEST (active statuses)
//   and the status profile to TJ30T (user status texts) and reading both
//   through filtered path expressions.
//
// Fields Added
//   UsageDecisionStatus - active user status code of the lot (filtered path)
//   UdSkippedText       - short text of the "UD skipped" status
//   UdRequiredText      - short text of the "UD required" status
//
// Associations Used
//   _Status          -> JEST   on Objnr = StatusObject, Inact = '' (active only)
//   _UserStatusText  -> TJ30T  on Stsma = StatusProfile, Spras = session language
//
// Patterns demonstrated
//   - declaring new associations inside a classic view extension
//   - filtered path expressions with a cardinality prefix - [1: ... ] - to
//     read exactly one row from a to-many association without multiplying
//     the result set
//   - resolving status texts in the session language instead of a fixed one
//
// Correctness notes
//   - An association target must be an entity (table/view). You cannot write
//     "association to _Jest": an association name is not a data source.
//   - JEST holds many active statuses per object, so the association is
//     [0..*] and the single value is selected with a filter. Declaring [1]
//     here would either multiply rows or claim a uniqueness that does not
//     exist.
//
// Adaptation note
//   E0001/E0002 are user status codes inside a status profile, i.e. system
//   configuration. Replace them with the codes of your own status profile.
//
// Common Use Cases
//   - Inspection lot list/reporting: show the usage-decision status as text
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_IL'

@EndUserText.label: 'I_InspectionLot Extend View'

extend view I_InspectionLot with ZSM_I_EXT_IL

  association [0..*] to jest  as _Status
    on  _Status.objnr = $projection.StatusObject
    and _Status.inact = ''

  association [0..*] to tj30t as _UserStatusText
    on  _UserStatusText.stsma = $projection.StatusProfile
    and _UserStatusText.spras = $session.system_language

{
  // Active user status of the lot, restricted to the two codes of interest
  _Status[1: stat = 'E0001' or stat = 'E0002' ].stat as UsageDecisionStatus,

  // Short texts of those two codes, in the session language
  _UserStatusText[1: estat = 'E0001' ].txt04         as UdSkippedText,
  _UserStatusText[1: estat = 'E0002' ].txt04         as UdRequiredText
}
