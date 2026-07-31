" ============================================================================
" Type        : ZSM_I_USERNAME_VH  (value help view)
" Module      : N/A (cross-application, BC user master)
" Business Object : User
" ----------------------------------------------------------------------------
" Description
"   Value help exposing SAP user names (USER_ADDR) with first/last name.
"
" Associations Used   (none)
"
" Common Use Cases
"   - F4 value help for a "created/responsible user" field
"
" Notes
"   - Trailing "where" clause in the source is empty/incomplete
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: ' Value Help'

@Search.searchable: true

define view entity ZSM_I_USERNAME_VH
  as select from user_addr

{
  key bname      as UserName,

      name_first as FirstName,
      name_last  as LastName
}

where 
