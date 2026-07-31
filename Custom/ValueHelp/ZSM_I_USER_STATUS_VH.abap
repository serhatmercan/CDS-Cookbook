" ============================================================================
" Type        : ZSM_I_USER_STATUS_VH  (value help view)
" Module      : PM
" Business Object : User Status (Status Profile ZPM)
" ----------------------------------------------------------------------------
" Description
"   Value help built on standard I_UserStatusText, filtered to the current
"   session language and hardcoded to status profile 'ZPM'.
"
" Associations Used   (none used beyond passthrough of _Language/_StatusProfile/_UserStatus)
"
" Common Use Cases
"   - F4 value help for user status fields on PM objects using profile ZPM
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'User Status Value Help'

@Search.searchable: true

define view entity ZSM_I_USER_STATUS_VH
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
  and StatusProfile = 'ZPM';
