" ============================================================================
" View        : ZSD_I_ORDER_DETAILS  (root view entity with ABAP-class-calculated virtual elements)
" Module      : SD
" Business Object : Sales Order
" ----------------------------------------------------------------------------
" Description
"   Joins sales order to delivery and exposes several virtual elements whose
"   values are calculated at runtime by an ABAP class (ObjectModel.virtualElementCalculatedBy).
"
" Common Use Cases
"   - Pattern for delegating field calculation to ABAP (ZSM_CL_TOTAL_ORDER) instead of SQL, via @ObjectModel.virtualElement
"
" Notes
"   - Virtual elements are declared with dummy CAST literals (0, '00000000'); actual values are supplied by the referenced ABAP class at read time
" ============================================================================

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

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      @Semantics.quantity.unitOfMeasure: 'VRKME_VL'
      cast(0 as abap.quan(13,3))    as lfimg_vl,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      @Semantics.amount.currencyCode: 'WAERK_VA'
      cast(0 as abap.curr(15,2))    as netwr_vf,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast('00000000' as abap.dats) as zadkllgt,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast(0 as abap.char(20))      as zihrlisno,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZSM_CL_TOTAL_ORDER'
      cast('00000000' as abap.dats) as zihrllgt
}
