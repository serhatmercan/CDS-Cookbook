" ============================================================================
" Type        : ZSM_I_SPECIAL_STOCK_VH  (root value help view)
" Module      : MM
" Business Object : Special Stock Indicator
" ----------------------------------------------------------------------------
" Description
"   Value help listing distinct special stock indicators (T148) with their
"   language-dependent short text (T148T).
"
" Associations Used   (none - plain join in the FROM clause)
"
" Common Use Cases
"   - F4 value help for a Special Stock Indicator (SOBKZ) field
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Special Stock Indicator Value Help'

@Search.searchable: true

define root view entity ZSM_I_SPECIAL_STOCK_VH
  as select distinct from t148  as t1

    left outer join       t148t as t2
      on  t2.sobkz = t1.sobkz
      and t2.spras = $session.system_language

{
  key t1.sobkz  as Sobkz,

      @Semantics.language: true
      @UI.hidden: true
  key t2.spras,

      @Search.defaultSearchElement: true
      @Semantics.text: true
      t2.sotxt  as Sotxt
}
