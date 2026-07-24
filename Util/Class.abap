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
