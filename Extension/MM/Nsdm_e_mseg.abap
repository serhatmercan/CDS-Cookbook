" ============================================================================
" Extension   : Nsdm_e_mseg  (extend view ... with ZSM_I_EXT_NSDM_E_MSEG)
" Module      : MM
" Business Object : Material Document (Goods Movement)
" ----------------------------------------------------------------------------
" Description
"   Pulls in all fields of the existing matdoc association (Material Document
"   Item) into nsdm_e_mseg via an include-association expansion.
"
" Fields Added
"   matdoc.  - all elements of the matdoc association (Material Document Item, MATDOC)
"
" Common Use Cases
"   - Custom MSEG-based reporting: enrich legacy movement view with S/4 MATDOC fields
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_NSDM_E_MSEG'

@EndUserText.label: 'NSDM_E_MSEG Extend View'

extend view nsdm_e_mseg with ZSM_I_EXT_NSDM_E_MSEG

{
  matdoc.
}
