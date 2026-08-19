// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : reusable pattern
// Extension  : nsdm_e_mseg  (extend view ... with ZSM_I_EXT_NSDM_E_MSEG)
// Module     : MM
// Business Object : Material Document (Goods Movement)
// ----------------------------------------------------------------------------
// Description
//   Adds MATDOC fields to the MSEG compatibility view, so reports that still
//   read the classic MSEG structure can see S/4HANA material document
//   attributes without being rewritten.
//
//   In S/4HANA, MSEG is a compatibility view (NSDM_E_MSEG / NSDM_V_MSEG) over
//   MATDOC. The append therefore reads from the matdoc data source that the
//   compatibility view already selects from.
//
// Fields Added
//   ZZBudat  - posting date        (matdoc.budat)
//   ZZCanc   - cancellation flag   (matdoc.cancelled)
//   ZZStckQ  - stock quantity      (matdoc.stock_qty)
//
// Patterns demonstrated
//   - extending an S/4HANA compatibility view
//   - naming concrete source fields in the append
//
// Correctness note
//   Each added element must name a concrete field, e.g. "matdoc.budat". A bare
//   "matdoc." (as an earlier revision had) is not a wildcard and does not
//   compile - CDS has no syntax for "add every field of a data source".
//
// Release note
//   NSDM_* compatibility views are release-dependent, and the set of fields
//   available on matdoc differs between releases. Check both in your system
//   before copying, and confirm the view is enabled for extension.
//
// Common Use Cases
//   - Keeping MSEG-based custom reports working while exposing S/4 fields
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_NSDM_E_MSEG'

@EndUserText.label: 'NSDM_E_MSEG Extend View'

extend view nsdm_e_mseg with ZSM_I_EXT_NSDM_E_MSEG

{
  matdoc.budat     as zzbudat,
  matdoc.cancelled as zzcanc,
  matdoc.stock_qty as zzstckq
}
