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
where   Language      = $session.system_language and 
        StatusProfile = 'ZPM';