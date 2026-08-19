// ============================================================================
// View        : ZSM_I_SUM_PRICING_ELEMENT  (root view entity, conditional SUM aggregation)
// Module      : SD
// Business Object : Billing Document
// ----------------------------------------------------------------------------
// Description
//   Reusable pattern for conditional SUM aggregation over pricing elements
//   reached via association, filtering by condition type and inactive/statistics flags.
//
// Common Use Cases
//   - Summing net value and tax amount from billing item pricing conditions, with a sign flip for returns. MWST is the standard SAP tax condition type; the net-value condition types are parameters.
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Invoice List'

define root view entity ZSM_I_SUM_PRICING_ELEMENT
  with parameters
    // Condition types are configuration - pass them in rather than hard-coding
    // one installation's pricing procedure into a reusable pattern.
    p_net_cond_1 : kschl,
    p_net_cond_2 : kschl

  as select from I_BillingDocumentItem

{
  key BillingDocument                              as vbeln_vf,

      // The currency element must exist in this projection for the
      // @Semantics.amount.currencyCode annotations below to resolve. It is in
      // the GROUP BY, which is not the same thing.
      _BillingDocument.TransactionCurrency           as WAERK,

      min(BillingDocumentItem)                       as posnr_vf,

      @Semantics.amount.currencyCode: 'WAERK'
      sum(
        case
          when (    _PricingElement.ConditionInactiveReason  is initial
                and _PricingElement.ConditionIsForStatistics is initial)
           and _PricingElement.ConditionType in ( .p_net_cond_1,
                                                  .p_net_cond_2 )
          then
            case
              when ReturnItemProcessingType = 'X' then _PricingElement.ConditionAmount * -1
              else _PricingElement.ConditionAmount
            end
          end)                 as net_value,

      @Semantics.amount.currencyCode: 'WAERK'
      sum(
          case
            when _PricingElement.ConditionInactiveReason  is initial
             and _PricingElement.ConditionIsForStatistics is initial
             and _PricingElement.ConditionType             = 'MWST'
            then
              case
                when ReturnItemProcessingType = 'X' then _PricingElement.ConditionAmount * -1
                else _PricingElement.ConditionAmount
              end
            end
          )                    as tax_amount
}

where _BillingDocument.BillingDocumentIsCancelled is initial
  and _BillingDocument.CancelledBillingDocument   is initial

group by BillingDocument,
         _BillingDocument.TransactionCurrency

// Type    : complete CDS (view entity)
// Context : reusable pattern
