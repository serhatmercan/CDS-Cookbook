" ============================================================================
" Type        : ZSD_I_INVOICE  (root view entity)
" Module      : SD (with IS-OIL license fields)
" Business Object : Billing Document
" ----------------------------------------------------------------------------
" Description
"   Billing document header + item (VBRK/VBRP) view, inner-joined to the
"   originating delivery (ZSD_I_DELIVERY) - which in turn carries the order
"   fields - so a single row exposes invoice, delivery and order data
"   together, plus payer name, billing type text, and IS-OIL license info.
"
" Associations Used
"   _Dlv (join) -> zsd_i_delivery   on vbeln_vl = vgbel and posnr_vl = vgpos
"   _Kna1       -> kna1             on kunnr = kunrg (payer)
"   _Tvfkt      -> tvfkt            billing type text
"   _Oihl       -> oihl             on licin = oih_licin_vf
"
" Common Use Cases
"   - End of the Order -> Delivery -> Invoice reporting chain; single view
"     for combined order/delivery/invoice reporting
"
" Related CDS
"   ZSD_I_ORDER, ZSD_I_DELIVERY
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Invoice Information'

define root view entity ZSD_I_INVOICE
  as select from vbrk

    inner join   vbrp
      on vbrk.vbeln = vbrp.vbeln

    inner join   zsd_i_delivery as _Dlv
      on  _Dlv.vbeln_vl = vbrp.vgbel
      and _Dlv.posnr_vl = vbrp.vgpos

  association [0..1] to kna1  as _Kna1
    on _Kna1.kunnr = vbrk.kunrg

  association [0..1] to tvfkt as _Tvfkt
    on  _Tvfkt.fkart = $projection.fkart
    and _Tvfkt.spras = 'T'

  association [0..1] to oihl  as _Oihl
    on _Oihl.licin = $projection.oih_licin_vf

{
  key vbrk.vbeln                       as vbeln_vf,
  key vbrp.posnr                       as posnr_vf,

      vbrp.vgbel                       as vgbel_vf,
      vbrp.vgpos                       as vgpos_vf,
      vbrk.belnr,
      vbrk.gjahr,
      vbrk.xblnr,
      vbrk.zuonr,
      vbrk.kunrg,
      concat(_Kna1.name1, _Kna1.name2) as kunrgx,
      vbrk.valdt                       as valdt_vf,
      vbrk.fkart,
      _Tvfkt.vtext                     as fkartx,
      vbrk.fkdat                       as fkdat_vf,
      vbrk.waerk                       as waerk_vf,
      vbrk.ernam                       as ernam_vf,
      vbrk.erdat                       as erdat_vf,
      vbrk.erzet                       as erzet_vf,
      vbrk.knumv                       as knumv_vf,
      vbrp.prsdt                       as prsdt_vf,
      vbrp.fkimg,
      vbrp.vbrkkme                     as vbrkkme_vf,
      vbrp.ntgew                       as netgw_vf,
      vbrp.gewei                       as gewei_vf,
      vbrp.meins                       as meins_vf,
      vbrp.volum                       as volum_vf,
      vbrp.voleh                       as voleh_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.netwr                       as netwr_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi1                       as kzwi1_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi2                       as kzwi2_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi3                       as kzwi3_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi4                       as kzwi4_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi6                       as kzwi6_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.mwsbp,

      vbrp.aubel,
      vbrp.aupos,
      vbrk.sfakn,
      vbrk.fksto,
      vbrp.bwtar                       as bwtar_vf,
      vbrk.zterm                       as zterm_vf,
      vbrp.werks,
      vbrp.shkzg                       as shkzg_vf,
      vbrk.valtg                       as valtg_vf,

      @Semantics.quantity.unitOfMeasure: 'MEINS_VF'
      vbrp.fklmg,

      _Oihl.lictp,
      vbrp.oih_licin                   as oih_licin_vf,
      _Oihl.lctxt                      as lctxt_vf,
      _Oihl.datab                      as datab_vf,
      _Oihl.datbi                      as datbi_vf,
      _Kna1.ktokd,
      _Dlv.vbeln_vl,
      _Dlv.posnr_vl,
      _Dlv.vgbel_vl,
      _Dlv.vgpos_vl,
      _Dlv.bwtar_vl,
      _Dlv.lgort,
      _Dlv.lgobe,
      _Dlv.vstel_vl,
      _Dlv.lfart,
      _Dlv.inco1_vl,
      _Dlv.inco2_vl,
      _Dlv.podat,
      _Dlv.potim,
      _Dlv.kunwe,
      _Dlv.kunwex,
      _Dlv.pdsta,
      _Dlv.wadat_ist,
      _Dlv.erzet_vl,
      _Dlv.erdat_vl,
      _Dlv.ernam_vl,
      _Dlv.lfimg_vl,
      _Dlv.vbrkkme_vl,
      _Dlv.ntgew_vl,
      _Dlv.gewei_vl,
      _Dlv.volum_vl,
      _Dlv.voleh_vl,
      _Dlv.meins_vl,
      _Dlv.mtart,
      _Dlv.lgmng_vl,
      _Dlv.wbsta,
      _Dlv.wbstk,
      _Dlv.dapgos,
      _Dlv.vbeln_va,
      _Dlv.posnr_va,
      _Dlv.trvog,
      _Dlv.vbtyp,
      _Dlv.Vbtypx,
      _Dlv.lifsk,
      _Dlv.bstnk,
      _Dlv.abgru,
      _Dlv.ABGRUX,
      _Dlv.audat,
      _Dlv.vdatu,
      _Dlv.kunag,
      _Dlv.kunagx,
      _Dlv.vkorg,
      _Dlv.vkorgx,
      _Dlv.vtweg,
      _Dlv.vtwegx,
      _Dlv.vkbur,
      _Dlv.vkburx,
      _Dlv.vkgrp,
      _Dlv.vkgrpx,
      _Dlv.erdat_va,
      _Dlv.erzet_va,
      _Dlv.ernam_va,
      _Dlv.knumv_va,
      _Dlv.autlf,
      _Dlv.gsber,
      _Dlv.bname,
      _Dlv.cmpsk,
      _Dlv.zz1_drivertcno_sdh,
      _Dlv.zz1_boruhattionay_sdh,
      _Dlv.zz1_boruhattonaytanm_sdh,
      _Dlv.zz1_sirano_sdh,
      _Dlv.zz1_tasitnumarasi_sdh,
      _Dlv.tasit1_text,
      _Dlv.zz1_tasitnumarasi2_sdh,
      _Dlv.tasit2_text,
      _Dlv.auart,
      _Dlv.auartx,
      _Dlv.shkzg_va,
      _Dlv.vstel_va,
      _Dlv.zz1_allocationperiod_sdi,
      _Dlv.prodh,
      _Dlv.matnr,
      _Dlv.maktx,
      _Dlv.mvgr1,
      _Dlv.mvgr2,
      _Dlv.mvgr3,
      _Dlv.kzwi1_va,
      _Dlv.kzwi2_va,
      _Dlv.kzwi3_va,
      _Dlv.kzwi4_va,
      _Dlv.kzwi5_va,
      _Dlv.kwmeng,
      _Dlv.vbrkkme_va,
      _Dlv.klmeng,
      _Dlv.meins_va,
      _Dlv.ntgew_va,
      _Dlv.gewei,
      _Dlv.volum_va,
      _Dlv.voleh_va,
      _Dlv.waerk_va,
      _Dlv.netwr_va,
      _Dlv.mwsbp_va,
      _Dlv.Pltyp,
      _Dlv.prsdt_va,
      _Dlv.fkdat_va,
      _Dlv.kdgrp,
      _Dlv.bzirk,
      _Dlv.empst,
      _Dlv.bstkd,
      _Dlv.bstdk,
      _Dlv.bsark,
      _Dlv.zterm_va,
      _Dlv.lcnum,
      _Dlv.abssc,
      _Dlv.traty,
      _Dlv.inco1_va,
      _Dlv.inco2_va,
      _Dlv.trmtyp,
      _Dlv.telf1,
      _Dlv.stcd1,
      _Dlv.stcd2,
      _Dlv.vsart,
      _Dlv.vsartx,
      _Dlv.zdehlno,
      _Dlv.first_name,
      _Dlv.last_name,
      _Dlv.drivercode,
      _Dlv.zdteln1,
      _Dlv.zdteln2,
      _Dlv.zdingilsayisi,
      _Dlv.ergei,
      _Dlv.zdara,
      _Dlv.ztoleransyba,
      _Dlv.TOLERANSLI_YBA_B,
      _Dlv.zdolumtipi,
      _Dlv.tankerdt,
      _Dlv.sipton,
      _Dlv.vdatu_va,
      _Dlv.zthbl,
      _Dlv.zthem,
      _Dlv.valtg_va,
      _Dlv.zmeng,
      _Dlv.zieme,
      _Dlv.lgort_va,
      _Dlv.mvgr1x,
      _Dlv.mvgr2x,
      _Dlv.mvgr3x,
      _Dlv.zgross_ton,
      _Dlv.nomtk
}
