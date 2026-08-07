" ============================================================================
" View        : ZSM_I_0006  (root view entity with MIN + CASE aggregation)
" Module      : SD
" Business Object : Billing Item
" ----------------------------------------------------------------------------
" Description
"   Reusable pattern for a conditional MIN aggregation (MIN of a value only
"   when a CASE condition matches) joined and grouped by document.
"
" Common Use Cases
"   - Picking the minimum value of a field only for rows matching a specific sub-type (here lictp = 'Z010')
"
" Notes
"   - Illustrates a conditional MIN() aggregation combined with a WHERE/GROUP BY
"     on the root alias (vbrp)
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Minimum'

define root view entity ZSM_I_0006
  as select from vbrp

    inner join   oihl
      on  oihl.licin = vbrp.oih_licin
      and oihl.lictp = vbrp.oih_lictp

{
  key vbrp.vbeln                                                as vbeln_vf,

      min(case when oihl.lictp = 'Z010' then vbrp.oidatto1 end) as amount
}

where vbrp.draft is initial
group by vbrp.vbeln
