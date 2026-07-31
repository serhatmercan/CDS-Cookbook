" ============================================================================
" View        : ZSM_I_0001  (root view entity with MAX aggregation)
" Module      : N/A
" Business Object : N/A
" ----------------------------------------------------------------------------
" Description
"   Reusable pattern for grouping by a key field and returning the MAX of
"   begin/end date columns.
"
" Common Use Cases
"   - Collapsing multiple date-range records per key down to the latest begin/end date
" ============================================================================

@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'Maximum Begin / End Date in ZSM_T_001'

@Metadata.ignorePropagatedAnnotations: true

define root view entity ZSM_I_0001
  as select from ZSM_T_001

{
  key plate,

      max(begda) as BeginDate,
      max(endda) as EndDate
}

group by plate
