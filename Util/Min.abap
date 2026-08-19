// ============================================================================
// View        : ZSM_I_MIN_LICENSE_DATE  (root view entity with MIN + CASE aggregation)
// Module      : SD
// Business Object : Billing Item
// ----------------------------------------------------------------------------
// Description
//   Reusable pattern for a conditional MIN aggregation (MIN of a value only
//   when a CASE condition matches) joined and grouped by document.
//
// Common Use Cases
//   - Picking the minimum value of a field only for rows matching a specific sub-type (the license type is a parameter)
//
// Notes
//   - Illustrates a conditional MIN() aggregation combined with a WHERE/GROUP BY
//     on the root alias (vbrp)
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Minimum'

define root view entity ZSM_I_MIN_LICENSE_DATE
  with parameters
    // License type is configuration - pass it in.
    p_license_type : oih_lictp

  as select from vbrp

    inner join   oihl
      on  oihl.licin = vbrp.oih_licin
      and oihl.lictp = vbrp.oih_lictp

{
  key vbrp.vbeln                                                as vbeln_vf,

      min(case when oihl.lictp = $parameters.p_license_type then vbrp.oidatto1 end) as earliest_valid_to_date
}

// The billing item table does not carry a release-independent "draft"
// indicator; an earlier revision filtered on one. Add your own exclusion
// (e.g. on the billing document status) if your release needs it.
group by vbrp.vbeln

// Type    : complete CDS (view entity)
// Context : reusable pattern
