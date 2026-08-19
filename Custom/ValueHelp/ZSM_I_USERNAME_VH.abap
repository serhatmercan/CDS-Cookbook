// ============================================================================
// Type       : complete CDS (view entity, value help)
// Context    : reusable pattern
// CDS        : ZSM_I_USERNAME_VH
// Module     : BC (cross-application, user master)
// Business Object : SAP User
// ----------------------------------------------------------------------------
// Description
//   Value help over SAP user names, restricted to dialog users that are not
//   locked and still valid, exposing the user ID and the display name.
//
// PRIVACY / SECURITY BOUNDARY - read before reusing
//   A user list is personal data. Two rules apply to this recipe:
//     1. Scope it. An unrestricted F4 over the full user master exposes every
//        account in the system, including technical and service users. This
//        view filters to unlocked dialog users within their validity period.
//     2. Protect it. @AccessControl.authorizationCheck: #NOT_REQUIRED means
//        no CDS access control is applied - it is a statement, not a
//        safeguard. If the consuming application must restrict who may browse
//        users, switch to #CHECK and provide a DCL role; #CHECK on its own,
//        with no applicable role, protects nothing.
//   Project only the attributes the F4 actually needs. First/last name are
//   sufficient to pick a user; email, phone, department and address data are
//   not, and are deliberately absent here.
//
// Patterns demonstrated
//   - value help over master data with a deliberate scoping WHERE clause
//   - @ObjectModel.text.element pairing an ID with its display text
//   - documenting the access-control boundary next to the annotation
//
// Common Use Cases
//   - F4 value help for a "created by" / "responsible user" field
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'User Name Value Help'

@Search.searchable: true

define view entity ZSM_I_USERNAME_VH
  as select from    user_addr as UserAddress

    inner join      usr02     as Logon
      on Logon.bname = UserAddress.bname

{
      @ObjectModel.text.element: [ 'FullName' ]
      @Search.defaultSearchElement: true
  key UserAddress.bname                                                     as UserName,

      @Search.defaultSearchElement: true
      @Semantics.text: true
      concat_with_space(UserAddress.name_first, UserAddress.name_last, 1)    as FullName
}

// Dialog users only, not locked, still valid on the current date.
where Logon.ustyp  = 'A'
  and Logon.uflag  = '0'
  and ( Logon.gltgb = '00000000' or Logon.gltgb >= $session.system_date )
