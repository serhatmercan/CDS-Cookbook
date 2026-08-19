// ============================================================================
// Type       : complete CDS (root view entity)
// Context    : genericised enterprise pattern
// CDS        : ZSD_I_INVOICE
// Module     : SD (with standard IS-OIL license objects)
// Business Object : Billing Document (header + item, flattened)
// ----------------------------------------------------------------------------
// Description
//   Billing document header + item (VBRK/VBRP) flattened into one row and
//   inner-joined to the originating delivery item (ZSD_I_DELIVERY) - which
//   already carries the sales order context - so a single row exposes
//   invoice, delivery and order data together.
//
//   The end of the order -> delivery -> invoice chain:
//     ZSD_I_ORDER -> ZSD_I_DELIVERY -> ZSD_I_INVOICE
//
// Patterns demonstrated
//   - joining a custom view entity as a data source (not only as association)
//   - document-flow join on VGBEL/VGPOS
//   - curated re-exposure of two upstream levels through one association-free
//     join alias
//   - @Semantics amount/quantity annotations bound to the currency/unit
//     element exposed in the same projection
//
// Join note
//   The delivery is joined with INNER JOIN, so invoice items without a
//   delivery reference (e.g. order-related billing) are excluded by design.
//   Switch to LEFT OUTER JOIN if you need those rows.
//
// Genericisation note
//   No personal-identity, phone or tax-number fields are exposed. Custom
//   append fields carry neutral ZZ_* names inherited from ZSD_I_ORDER.
//
// Related CDS
//   ZSD_I_ORDER, ZSD_I_DELIVERY
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: #NOT_REQUIRED means no CDS access control is applied.
// Billing data normally requires a DCL role designed for the consuming
// application; #CHECK without an applicable role provides no protection.

@EndUserText.label: 'Invoice Information'

define root view entity ZSD_I_INVOICE
  as select from vbrk

    inner join   vbrp
      on vbrk.vbeln = vbrp.vbeln

    inner join   ZSD_I_DELIVERY as _Dlv
      on  _Dlv.vbeln_vl = vbrp.vgbel
      and _Dlv.posnr_vl = vbrp.vgpos

  association [0..1] to kna1  as _PayerParty
    on _PayerParty.kunnr = vbrk.kunrg

  association [0..1] to tvfkt as _BillingTypeText
    on  _BillingTypeText.fkart = $projection.fkart
    and _BillingTypeText.spras = $session.system_language

  association [0..1] to oihl  as _License
    on _License.licin = $projection.oih_licin_vf

{
  key vbrk.vbeln                                                    as vbeln_vf,
  key vbrp.posnr                                                    as posnr_vf,

      // ---------- Billing header ----------
      vbrk.belnr,
      vbrk.gjahr,
      vbrk.xblnr,
      vbrk.zuonr,
      vbrk.fksto,
      vbrk.sfakn,

      vbrk.fkart,
      _BillingTypeText.vtext                                        as fkartx,

      vbrk.fkdat                                                    as fkdat_vf,
      vbrk.valdt                                                    as valdt_vf,
      vbrk.valtg                                                    as valtg_vf,
      vbrk.zterm                                                    as zterm_vf,
      vbrk.erdat                                                    as erdat_vf,
      vbrk.erzet                                                    as erzet_vf,
      vbrk.ernam                                                    as ernam_vf,
      vbrk.knumv                                                    as knumv_vf,

      vbrk.kunrg,
      concat_with_space(_PayerParty.name1, _PayerParty.name2, 1)    as kunrgx,
      _PayerParty.ktokd                                             as ktokd_vf,

      // ---------- Billing item ----------
      vbrp.vgbel                                                    as vgbel_vf,
      vbrp.vgpos                                                    as vgpos_vf,
      vbrp.aubel,
      vbrp.aupos,
      vbrp.werks,
      vbrp.bwtar                                                    as bwtar_vf,
      vbrp.shkzg                                                    as shkzg_vf,
      vbrp.prsdt                                                    as prsdt_vf,

      vbrp.vrkme                                                    as vrkme_vf,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VF'
      vbrp.fkimg,

      vbrp.meins                                                    as meins_vf,

      @Semantics.quantity.unitOfMeasure: 'MEINS_VF'
      vbrp.fklmg,

      vbrp.gewei                                                    as gewei_vf,

      @Semantics.quantity.unitOfMeasure: 'GEWEI_VF'
      vbrp.ntgew                                                    as netgw_vf,

      vbrp.voleh                                                    as voleh_vf,

      @Semantics.quantity.unitOfMeasure: 'VOLEH_VF'
      vbrp.volum                                                    as volum_vf,

      vbrk.waerk                                                    as waerk_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.netwr                                                    as netwr_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.mwsbp,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi1                                                    as kzwi1_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi2                                                    as kzwi2_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi3                                                    as kzwi3_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi4                                                    as kzwi4_vf,

      @Semantics.amount.currencyCode: 'WAERK_VF'
      vbrp.kzwi6                                                    as kzwi6_vf,

      // ---------- IS-OIL license ----------
      vbrp.oih_licin                                                as oih_licin_vf,
      _License.lictp                                                as lictp_vf,
      _License.lctxt                                                as lctxt_vf,
      _License.datab                                                as datab_vf,
      _License.datbi                                                as datbi_vf,

      // ---------- Curated re-exposure of the delivery ----------
      _Dlv.vbeln_vl,
      _Dlv.posnr_vl,
      _Dlv.vgbel_vl,
      _Dlv.vgpos_vl,
      _Dlv.lfart,
      _Dlv.vstel_vl,
      _Dlv.werks                                                    as werks_vl,
      _Dlv.lgort,
      _Dlv.lgobe,
      _Dlv.mtart,
      _Dlv.bwtar_vl,
      _Dlv.wadat_ist,
      _Dlv.podat,
      _Dlv.potim,
      _Dlv.pdsta,
      _Dlv.wbsta,
      _Dlv.wbstk,
      _Dlv.erdat_vl,
      _Dlv.ernam_vl,
      _Dlv.kunwe,
      _Dlv.kunwex,
      _Dlv.inco1_vl,
      _Dlv.inco2_vl,

      _Dlv.vrkme_vl,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VL'
      _Dlv.lfimg_vl,

      _Dlv.meins_vl,

      @Semantics.quantity.unitOfMeasure: 'MEINS_VL'
      _Dlv.lgmng_vl,

      _Dlv.gewei_vl,

      @Semantics.quantity.unitOfMeasure: 'GEWEI_VL'
      _Dlv.ntgew_vl,

      _Dlv.voleh_vl,

      @Semantics.quantity.unitOfMeasure: 'VOLEH_VL'
      _Dlv.volum_vl,

      // ---------- Curated re-exposure of the sales order ----------
      _Dlv.vbeln_va,
      _Dlv.posnr_va,
      _Dlv.auart,
      _Dlv.auartx,
      _Dlv.vbtyp,
      _Dlv.vbtypx,
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
      _Dlv.matnr,
      _Dlv.maktx,
      _Dlv.prodh,
      _Dlv.mvgr1,
      _Dlv.mvgr2,
      _Dlv.mvgr3,

      _Dlv.vrkme_va,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      _Dlv.kwmeng,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      _Dlv.klmeng,

      _Dlv.waerk_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      _Dlv.netwr_va,

      _Dlv.zterm_va,

      // Custom append fields (neutral names - replace with your own)
      _Dlv.zz_driver_code,
      _Dlv.zz_vehicle_1,
      _Dlv.vehicle_1_text,
      _Dlv.zz_vehicle_2,
      _Dlv.vehicle_2_text,
      _Dlv.zz_loading_seq,
      _Dlv.zz_alloc_period,

      _Dlv.nomtk
}
