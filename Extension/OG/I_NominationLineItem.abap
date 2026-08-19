// ============================================================================
// Type       : extension (classic extend view + append)
// Context    : genericised enterprise pattern
// Extension  : I_NominationLineItem  (extend view ... with ZSM_I_EXT_NLI)
// Module     : OG (Oil & Gas / TSW Nomination)
// Business Object : Nomination Line Item
// ----------------------------------------------------------------------------
// Description
//   Adds custom append fields of the TSW nomination item table (OIJNOMI) to
//   the standard Nomination Line Item view, by associating the standard view
//   back to the table it is built on.
//
// Fields Added
//   zz_allocation_qty - custom append field on OIJNOMI (allocation quantity)
//   zz_discharge_qty  - custom append field on OIJNOMI (discharge quantity)
//
// Associations Used
//   _Nomination -> oijnomi   on nomtk = NominationDoc, nomit = NominationDocItem
//
// Patterns demonstrated
//   - reaching custom append fields of the underlying table from an extension
//     of the standard view above it
//   - a [0..1] association on the full key of the underlying table
//
// Genericisation note
//   The two element names are neutral placeholders for your own OIJNOMI
//   appends. OIJNOMI itself is standard IS-OIL/TSW - only the append fields
//   are customer-specific.
//
// Common Use Cases
//   - Nomination line item list: display custom quantity fields alongside
//     the standard nomination data
// ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_NLI'

@EndUserText.label: 'I_NominationLineItem Extend View'

extend view I_NominationLineItem with ZSM_I_EXT_NLI

  association [0..1] to oijnomi as _Nomination
    on  _Nomination.nomtk = $projection.NominationDoc
    and _Nomination.nomit = $projection.NominationDocItem

{
  _Nomination.zz_allocation_qty,
  _Nomination.zz_discharge_qty
}
