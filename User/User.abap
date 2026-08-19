// ============================================================================
// Type       : complete CDS (classic define view)
// Context    : reusable pattern
// View       : ZUSERS  (SAP user master data view)
// Module     : BC
// Business Object : SAP User
// ----------------------------------------------------------------------------
// Description
//   Combines user master (USR02), logon/address link (USR21), person address
//   (ADRP) and license type (USR06) into one row per SAP user: name, license
//   type, user type, lock status, validity and organisational assignment.
//
// PRIVACY BOUNDARY - read before reusing
//   User master data is personal data. Two changes were made to this recipe
//   for exactly that reason:
//     1. Contact details are no longer projected. The email join (ADR6) and
//        the company-address join (ADCP) were removed: a user *inventory* does
//        not need an inbox address to be useful, and a reporting view that
//        carries one becomes a data-protection question in every review.
//        If your use case genuinely requires them, add the joins back
//        deliberately and document why.
//     2. The access-control annotation is documented rather than trusted.
//        @AccessControl.authorizationCheck: #CHECK only takes effect if a DCL
//        role exists for this entity. With no applicable role, #CHECK grants
//        no protection at all - it is not a substitute for one. This
//        repository does not ship a DCL role: design one for your application
//        (typically over S_USER_GRP or an application-specific object).
//
// Classic-view note
//   A classic "define view" requires @AbapCatalog.sqlViewName - the generated
//   DDIC SQL view. Without it the source does not activate. The compiler
//   options below are the usual pair for a classic view over base tables.
//   For anything new, prefer "define view entity", which needs no SQL view.
//
// Patterns demonstrated
//   - classic define view with the annotations it cannot omit
//   - the ADRP current-address idiom (DATE_FROM = '00010101', NATION = ' ')
//   - CAST to trim a long field to a reporting length
//
// Common Use Cases
//   - User inventory / licence-type reporting, lock and validity review
// ============================================================================

@AbapCatalog.sqlViewName: 'ZSMVUSERS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true

@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'SAP Users'

define view ZUSERS
  as select from    usr02

    left outer join usr21
      on usr21.bname = usr02.bname

    left outer join adrp
      on  adrp.persnumber = usr21.persnumber
      and adrp.date_from  = '00010101'
      and adrp.nation     = ' '

    left outer join usr06
      on usr06.bname = usr02.bname

{
  key usr02.bname,

      usr06.lic_type,
      usr02.ustyp,
      usr02.uflag,
      usr02.gltgb,
      usr02.class,

      cast(adrp.name_text as abap.char(80)) as name_text,
      adrp.name_first,
      adrp.name_last,

      usr21.persnumber,
      usr21.addrnumber
}
