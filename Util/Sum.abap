" ============================================================================
" View        : ZSM_I_0003  (root view entity with conditional SUM aggregation)
" Module      : SD
" Business Object : Billing Document
" ----------------------------------------------------------------------------
" Description
"   Reusable pattern for conditional SUM aggregation over pricing elements
"   reached via association, filtering by condition type and inactive/statistics flags.
"
" Common Use Cases
"   - Summing net value and tax amount from billing item pricing conditions (ZP01/ZP02, MWST), with sign flip for returns
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Invoice List'

define root view entity ZSM_I_0003
  as select from I_BillingDocumentItem

{
  key BillingDocument          as vbeln_vf,

      min(BillingDocumentItem) as posnr_vf,

      @Semantics.amount.currencyCode: 'WAERK'
      sum(
        case
          when (    _PricingElement.ConditionInactiveReason  is initial
                and _PricingElement.ConditionIsForStatistics is initial)
           and (    _PricingElement.ConditionType             = 'ZP01'
                or  _PricingElement.ConditionType             = 'ZP02')
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
