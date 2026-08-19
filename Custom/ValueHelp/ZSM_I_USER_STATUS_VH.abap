// ============================================================================
// Type       : complete CDS (view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_USER_STATUS_VH  (value help view)
// Module      : PM
// Business Object : User Status
// ----------------------------------------------------------------------------
// Description
//   Value help built on standard I_UserStatusText, filtered to the current
//   session language and to the status profile passed as a parameter.
//
// Associations Used   (none used beyond passthrough of _Language/_StatusProfile/_UserStatus)
//
// Common Use Cases
//   - F4 value help for user status fields, scoped to one status profile
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'User Status Value Help'

@Search.searchable: true

define view entity ZSM_I_USER_STATUS_VH
  with parameters
    // Status profile is configuration - pass it in instead of hard-coding one.
    p_status_profile : j_stsma

  as select from I_UserStatusText

{
  key UserStatus,
  key StatusProfile,
  key Language,

      UserStatusName,
      UserStatusShortName,

      /* Associations */
      _Language,
      _StatusProfile,
      _UserStatus
}

where Language      = $session.system_language
  and StatusProfile = $parameters.p_status_profile
