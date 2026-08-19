// ============================================================================
// Type       : complete CDS (root view entity)
// Context    : genericised enterprise pattern
// CDS        : ZSD_I_DELIVERY
// Module     : SD / LE (with standard IS-OIL license objects)
// Business Object : Outbound Delivery (header + item, flattened)
// ----------------------------------------------------------------------------
// Description
//   Delivery header + item (LIKP/LIPS) flattened into one row and associated
//   back to the originating sales order (ZSD_I_ORDER) via VGBEL/VGPOS, with
//   ship-to name, storage-location description and IS-OIL license header.
//
//   The middle link of the order -> delivery -> invoice chain:
//     ZSD_I_ORDER -> ZSD_I_DELIVERY -> ZSD_I_INVOICE
//
// Patterns demonstrated
//   - document-flow association upstream via VGBEL/VGPOS
//   - selective re-exposure of upstream elements (a curated subset, so the
//     consumer contract stays reviewable instead of a 150-element passthrough)
//   - classic text-table lookups (T001L storage location)
//   - @Semantics quantity/amount annotations re-declared on re-exposed
//     elements, bound to the unit/currency element exposed alongside them
//
// Key note
//   The key is header AND item (VBELN_VL + POSNR_VL). LIPS is joined, so a
//   header-only key would not be unique.
//
// Genericisation note
//   Custom append fields are shown with neutral ZZ_* names inherited from
//   ZSD_I_ORDER. No personal-identity, phone or tax-number fields are exposed.
//
// Related CDS
//   ZSD_I_ORDER, ZSD_I_INVOICE
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: #NOT_REQUIRED means no CDS access control is applied.
// Design a DCL role for the consuming application; #CHECK without an
// applicable role does not protect the data either.

@EndUserText.label: 'Delivery Information'

define root view entity ZSD_I_DELIVERY
  as select from likp

    inner join   lips on lips.vbeln = likp.vbeln

  // Upstream sales order item (document flow)
  association [0..1] to ZSD_I_ORDER as _Ord
    on  _Ord.vbeln_va = $projection.vgbel_vl
    and _Ord.posnr_va = $projection.vgpos_vl

  association [0..1] to kna1        as _ShipToParty
    on _ShipToParty.kunnr = $projection.kunwe

  association [0..1] to t001l       as _StorageLocation
    on  _StorageLocation.werks = $projection.werks
    and _StorageLocation.lgort = $projection.lgort

  association [0..1] to oihl        as _License
    on _License.licin = $projection.oih_licin_vl

{
  key likp.vbeln                                                     as vbeln_vl,
  key lips.posnr                                                     as posnr_vl,

      // ---------- Delivery header ----------
      likp.vstel                                                     as vstel_vl,
      likp.lfart,
      likp.inco1                                                     as inco1_vl,
      likp.inco2                                                     as inco2_vl,
      likp.podat,
      likp.potim,
      likp.wadat_ist,
      likp.wauhr,
      likp.wbstk,
      likp.erdat                                                     as erdat_vl,
      likp.erzet                                                     as erzet_vl,
      likp.ernam                                                     as ernam_vl,

      likp.kunnr                                                     as kunwe,
      concat_with_space(_ShipToParty.name1, _ShipToParty.name2, 1)   as kunwex,

      // ---------- Delivery item ----------
      lips.vgbel                                                     as vgbel_vl,
      lips.vgpos                                                     as vgpos_vl,
      lips.bwtar                                                     as bwtar_vl,
      lips.werks,
      lips.lgort,
      _StorageLocation.lgobe                                         as lgobe,
      lips.mtart,
      lips.pdsta,
      lips.wbsta,

      lips.vrkme                                                     as vrkme_vl,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VL'
      lips.lfimg                                                     as lfimg_vl,

      lips.meins                                                     as meins_vl,

      @Semantics.quantity.unitOfMeasure: 'MEINS_VL'
      lips.lgmng                                                     as lgmng_vl,

      lips.gewei                                                     as gewei_vl,

      @Semantics.quantity.unitOfMeasure: 'GEWEI_VL'
      lips.ntgew                                                     as ntgew_vl,

      lips.voleh                                                     as voleh_vl,

      @Semantics.quantity.unitOfMeasure: 'VOLEH_VL'
      lips.volum                                                     as volum_vl,

      // ---------- IS-OIL license ----------
      lips.oih_licin                                                 as oih_licin_vl,
      _License.lictp                                                 as lictp_vl,
      _License.lctxt                                                 as lctxt_vl,
      _License.datab                                                 as datab_vl,
      _License.datbi                                                 as datbi_vl,

      // ---------- Derived: incoterms / POD status marker ----------
      // Concatenates the order incoterms with the item POD status when the
      // order was created under a specific incoterms classification.
      case when _Ord.inco1_va = 'DAP' then concat(_Ord.inco1_va, lips.pdsta)
           else                             ''
      end                                                            as incoterms_pod_status,

      // ---------- Curated re-exposure of the sales order ----------
      _Ord.vbeln_va,
      _Ord.posnr_va,
      _Ord.auart,
      _Ord.auartx,
      _Ord.vbtyp,
      _Ord.vbtypx,
      _Ord.erdat_va,
      _Ord.ernam_va,

      _Ord.kunag,
      _Ord.kunagx,
      _Ord.ktokd,

      _Ord.vkorg,
      _Ord.vkorgx,
      _Ord.vtweg,
      _Ord.vtwegx,
      _Ord.vkbur,
      _Ord.vkburx,
      _Ord.vkgrp,
      _Ord.vkgrpx,

      _Ord.matnr,
      _Ord.maktx,
      _Ord.prodh,
      _Ord.mvgr1,
      _Ord.mvgr2,
      _Ord.mvgr3,

      _Ord.vrkme_va,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      _Ord.kwmeng,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      _Ord.klmeng,

      _Ord.gewei,

      @Semantics.quantity.unitOfMeasure: 'GEWEI'
      _Ord.ntgew_va,

      _Ord.voleh_va,

      @Semantics.quantity.unitOfMeasure: 'VOLEH_VA'
      _Ord.volum_va,

      _Ord.waerk_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      _Ord.netwr_va,

      _Ord.inco1_va,
      _Ord.inco2_va,
      _Ord.zterm_va,

      // Custom append fields (neutral names - replace with your own)
      _Ord.zz_driver_code,
      _Ord.zz_vehicle_1,
      _Ord.vehicle_1_text,
      _Ord.zz_vehicle_2,
      _Ord.vehicle_2_text,
      _Ord.zz_loading_seq,
      _Ord.zz_alloc_period,

      _Ord.nomtk
}
