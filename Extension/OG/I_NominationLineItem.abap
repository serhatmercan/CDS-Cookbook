" ============================================================================
" Extension   : I_NominationLineItem  (extend view ... with ZSM_I_EXT_NLI)
" Module      : OG (Oil & Gas / TSW Nomination)
" Business Object : Nomination Line Item
" ----------------------------------------------------------------------------
" Description
"   Adds two custom NIM (nomination item) fields sourced from the TSW
"   nomination item table oijnomi.
"
" Fields Added
"   zz1_supalan_nim - custom field from oijnomi
"   zz1_tahlim_nim  - custom field from oijnomi
"
" Associations Used
"   _Oijnomi -> oijnomi   on nomtk = nominationdoc, nomit = nominationdocitem
"
" Common Use Cases
"   - Nomination line item list: display custom allocation/analysis fields
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_NLI'

@EndUserText.label: 'I_NominationLineItem Extend View'

extend view I_NominationLineItem with ZSM_I_EXT_NLI

  association [0..1] to oijnomi as _Oijnomi
    on  _Oijnomi.nomtk = $projection.nominationdoc
    and _Oijnomi.nomit = $projection.nominationdocitem

{
  _Oijnomi.zz1_supalan_nim,
  _Oijnomi.zz1_tahlim_nim
}
