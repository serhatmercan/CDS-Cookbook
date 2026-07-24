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
