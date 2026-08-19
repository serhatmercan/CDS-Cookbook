// ============================================================================
// View        : ZSD_I_ORDER_DETAILS  (root view entity with ABAP-class-calculated virtual elements)
// Module      : SD
// Business Object : Sales Order
// ----------------------------------------------------------------------------
// Description
//   Joins sales order to delivery and exposes several virtual elements whose
//   values are calculated at runtime by an ABAP class (ObjectModel.virtualElementCalculatedBy).
//
// Common Use Cases
//   - Pattern for delegating field calculation to ABAP (ZSM_CL_TOTAL_ORDER) instead of SQL, via @ObjectModel.virtualElement
//
// Notes
//   - Virtual elements are declared with dummy CAST literals (0, '00000000'); actual values are supplied by the referenced ABAP class at read time
//   - @Semantics unit/currency annotations must reference an element of THIS
//     projection. The unit and currency elements are projected alongside the
//     virtual elements for exactly that reason.
//   - Virtual elements are calculated per result page in ABAP, so the class
//     must stay cheap and must not be filterable unless a filter exit is
//     provided as well (see Extension/PM for that pattern).
//
// Type       : complete CDS (view entity)
// Context    : reusable pattern
// Dependencies
//   ZSD_I_ORDER, ZSD_I_DELIVERY (Custom/SD), ZSM_CL_TOTAL_ORDER (not in this repo)
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Order Detail'

@Metadata.ignorePropagatedAnnotations: true

define root view entity ZSD_I_ORDER_DETAILS
  as select from zsd_i_order as Ord

  association [0..1] to zsd_i_delivery as _Dlv
    on  _Dlv.vgbel_vl = $projection.vbeln_va
    and _Dlv.vgpos_vl = $projection.posnr_va

{
  key Ord.vbeln_va,
  key Ord.posnr_va,

      _Dlv.vbeln_vl,
      _Dlv.posnr_vl,
      _Dlv.vgbel_vl,
      _Dlv.vgpos_vl,

      // A @Semantics unit/currency annotation must name an element that this
      // view actually exposes. Both reference elements are therefore projected
      // here - annotating against an element of the underlying view that is not
      // in this projection does not activate.
      _Dlv.vrkme_vl,
      Ord.waerk_va,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      @Semantics.quantity.unitOfMeasure: 'VRKME_VL'
      cast(0 as abap.quan(13,3))    as total_delivered_qty,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      @Semantics.amount.currencyCode: 'WAERK_VA'
      cast(0 as abap.curr(15,2))    as total_invoiced_amount,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast('00000000' as abap.dats) as first_shipment_date,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast('00000000' as abap.dats) as last_shipment_date,

      // Placeholder literals must match the element type: cast a character
      // literal to a character type, not a numeric 0.
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast('' as abap.char(20))     as external_reference
}
