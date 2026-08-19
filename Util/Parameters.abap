// ============================================================================
// View        : ZSM_I_AVG_CONDITION_PRICE  (root view entity with input parameters)
// Module      : SD
// Business Object : Pricing Condition
// ----------------------------------------------------------------------------
// Description
//   Reusable pattern for a parameterized CDS view ($parameters) that prorates
//   a condition amount when the condition's validity period only partially
//   overlaps the requested date range.
//
// Common Use Cases
//   - Average/prorated price calculation for a given period using $parameters.p_datab / p_datbi against condition tables A904/KONP
// ============================================================================

@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'Average Price'

define root view entity ZSM_I_AVG_CONDITION_PRICE
  with parameters
    p_datab          : abap.dats,
    p_datbi          : abap.dats,
    // Condition type is configuration - pass it in.
    p_condition_type : kschl

  as select from a904

    inner join   konp on konp.knumh = a904.knumh

{
  key a904.vkorg,
  key a904.matnr,
  key cast(substring(cast($parameters.p_datab as abap.char(8)), 1, 6) as abap.numc(6)) as spmon,

      case
        when a904.datab <= $parameters.p_datab and a904.datbi < $parameters.p_datbi
          then cast(konp.kbetr as abap.fltp) *
               cast((dats_days_between($parameters.p_datab, a904.datbi) + 1) as abap.fltp) /
               cast((dats_days_between($parameters.p_datab, $parameters.p_datbi) + 1) as abap.fltp)
          else cast(konp.kbetr as abap.fltp)
      end                                                        as kbetr
}

where a904.kappl  = 'V'
  and a904.kschl  = $parameters.p_condition_type
  and a904.datbi >= $parameters.p_datab
  and a904.datab <= $parameters.p_datbi

// Type    : complete CDS (view entity)
// Context : reusable pattern
