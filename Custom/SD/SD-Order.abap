// ============================================================================
// Type       : complete CDS (root view entity)
// Context    : genericised enterprise pattern
// CDS        : ZSD_I_ORDER
// Module     : SD (with standard IS-OIL objects: vehicle, driver, nomination, license)
// Business Object : Sales Order (header + item, flattened)
// ----------------------------------------------------------------------------
// Description
//   Sales order header + item (VBAK/VBAP) flattened into one row, with:
//     - billing/business data from VBKD using the item-then-header-item-0
//       fallback pattern (_Vbkd / _Vbkd2)
//     - ship-to partner from VBPA (filtered association on PARVW/POSNR)
//     - IS-OIL vehicle master + language-dependent vehicle text (OIGV/OIGVT)
//     - IS-OIL driver master (OIGD), associated by driver code
//     - IS-OIL open nomination reference (OIJNOMI) and license header (OIHL)
//     - nine domain text-table associations (order type, sales org, channel,
//       office, group, rejection reason, material groups) resolved in the
//       session language
//     - debit/credit sign handling driven by VBAP-SHKZG
//
// Patterns demonstrated
//   - header/item flattening with a two-part key
//   - twin association + CASE fallback (item value, else header item '000000')
//   - filtered associations (partner function, language, deletion indicator)
//   - text-table associations resolved with $session.system_language
//   - CASE-based sign inversion for returns/credit items
//   - @Semantics amount/quantity annotations bound to the matching
//     currency/unit element in the same projection
//
// Genericisation note
//   Custom append fields on VBAK/VBAP are shown with neutral ZZ_* names
//   (ZZ_DRIVER_CODE, ZZ_VEHICLE_1, ZZ_VEHICLE_2, ZZ_LOADING_SEQ,
//   ZZ_ALLOC_PERIOD). Replace them with your own append field names. No
//   personal-identity, phone or tax-number fields are exposed by this
//   example - a driver is referenced by driver code only.
//
// Adaptation note
//   Organisational and document-type filtering is intentionally NOT part of
//   this view; add your own WHERE/parameter restrictions. TRVOG = '0'
//   (standard order) is a standard SAP domain value, not customer config.
//
// Related CDS
//   ZSD_I_DELIVERY, ZSD_I_INVOICE, ZSD_I_ORDER_DETAILS (Util/Class.abap)
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: #NOT_REQUIRED means no CDS access control is applied.
// A productive view over sales data needs a DCL role designed for the
// application; #CHECK alone provides no protection unless a role exists.

@EndUserText.label: 'Order Information'

define root view entity ZSD_I_ORDER
  as select from vbak

    inner join   vbap on vbak.vbeln = vbap.vbeln

  // Business data of the item, with fallback to the header item '000000'
  association [0..1] to vbkd    as _Vbkd
    on  _Vbkd.vbeln = $projection.vbeln_va
    and _Vbkd.posnr = $projection.posnr_va

  association [0..1] to vbkd    as _Vbkd2
    on  _Vbkd2.vbeln = $projection.vbeln_va
    and _Vbkd2.posnr = '000000'

  // Ship-to party (partner function WE on header level)
  association [0..1] to vbpa    as _Vbpa
    on  _Vbpa.vbeln = $projection.vbeln_va
    and _Vbpa.parvw = 'WE'
    and _Vbpa.posnr = '000000'

  association [0..1] to kna1    as _SoldToParty
    on _SoldToParty.kunnr = $projection.kunag

  // IS-OIL driver master, referenced by driver code (no personal identifier)
  association [0..1] to oigd    as _Driver
    on _Driver.drivercode = $projection.zz_driver_code

  // IS-OIL vehicle master + text, for both vehicle fields
  association [0..1] to oigv    as _Vehicle
    on _Vehicle.vehicle = $projection.zz_vehicle_1

  association [0..1] to oigvt   as _VehicleText
    on  _VehicleText.vehicle  = $projection.zz_vehicle_1
    and _VehicleText.language = $session.system_language

  association [0..1] to oigvt   as _VehicleText2
    on  _VehicleText2.vehicle  = $projection.zz_vehicle_2
    and _VehicleText2.language = $session.system_language

  // IS-OIL nomination reference (not flagged for deletion)
  association [0..1] to oijnomi as _Nomination
    on  _Nomination.docnr  = $projection.vbeln_va
    and _Nomination.docitm = $projection.posnr_va
    and _Nomination.delind = ''

  // IS-OIL license header
  association [0..1] to oihl    as _License
    on _License.licin = $projection.oih_licin_va

  // Domain text tables, resolved in the session language
  association [0..1] to tvakt   as _OrderTypeText
    on  _OrderTypeText.auart = $projection.auart
    and _OrderTypeText.spras = $session.system_language

  association [0..1] to tvkot   as _SalesOrgText
    on  _SalesOrgText.vkorg = $projection.vkorg
    and _SalesOrgText.spras = $session.system_language

  association [0..1] to tvtwt   as _DistrChannelText
    on  _DistrChannelText.vtweg = $projection.vtweg
    and _DistrChannelText.spras = $session.system_language

  association [0..1] to tvkbt   as _SalesOfficeText
    on  _SalesOfficeText.vkbur = $projection.vkbur
    and _SalesOfficeText.spras = $session.system_language

  association [0..1] to tvgrt   as _SalesGroupText
    on  _SalesGroupText.vkgrp = $projection.vkgrp
    and _SalesGroupText.spras = $session.system_language

  association [0..1] to tvagt   as _RejectionReasonText
    on  _RejectionReasonText.abgru = $projection.abgru
    and _RejectionReasonText.spras = $session.system_language

  association [0..1] to tvm1t   as _MatlGroup1Text
    on  _MatlGroup1Text.mvgr1 = $projection.mvgr1
    and _MatlGroup1Text.spras = $session.system_language

  association [0..1] to tvm2t   as _MatlGroup2Text
    on  _MatlGroup2Text.mvgr2 = $projection.mvgr2
    and _MatlGroup2Text.spras = $session.system_language

  association [0..1] to tvm3t   as _MatlGroup3Text
    on  _MatlGroup3Text.mvgr3 = $projection.mvgr3
    and _MatlGroup3Text.spras = $session.system_language

{
  key vbak.vbeln                                                              as vbeln_va,
  key vbap.posnr                                                              as posnr_va,

      // ---------- Header: category, status, dates ----------
      vbak.trvog,
      vbak.vbtyp,

      // CASE on the standard SD document category domain
      case vbak.vbtyp
        when 'C' then 'Order'
        when 'H' then 'Return'
        else          'Other'
      end                                                                     as vbtypx,

      vbak.lifsk,
      vbak.bstnk,
      vbak.audat,
      vbak.vdatu,
      vbak.autlf,
      vbak.gsber,
      vbak.bname,
      vbak.cmpsk,
      vbak.cmgst,
      vbak.erdat                                                              as erdat_va,
      vbak.erzet                                                              as erzet_va,
      vbak.ernam                                                              as ernam_va,
      vbak.knumv                                                              as knumv_va,

      vbak.auart,
      _OrderTypeText.bezei                                                    as auartx,

      // ---------- Header: sold-to and organisation ----------
      vbak.kunnr                                                              as kunag,
      concat_with_space(_SoldToParty.name1, _SoldToParty.name2, 1)            as kunagx,
      _SoldToParty.ktokd,

      _Vbpa.kunnr                                                             as kunwe_va,

      vbak.vkorg,
      _SalesOrgText.vtext                                                     as vkorgx,
      vbak.vtweg,
      _DistrChannelText.vtext                                                 as vtwegx,
      vbak.vkbur,
      _SalesOfficeText.bezei                                                  as vkburx,
      vbak.vkgrp,
      _SalesGroupText.bezei                                                   as vkgrpx,

      // ---------- Item: product, plant, groups ----------
      vbap.abgru,
      _RejectionReasonText.bezei                                              as abgrux,
      vbap.shkzg                                                              as shkzg_va,
      vbap.werks,
      vbap.vstel                                                              as vstel_va,
      vbap.lgort                                                              as lgort_va,
      vbap.prodh,
      vbap.matnr,
      vbap.arktx                                                              as maktx,

      vbap.mvgr1,
      _MatlGroup1Text.bezei                                                   as mvgr1x,
      vbap.mvgr2,
      _MatlGroup2Text.bezei                                                   as mvgr2x,
      vbap.mvgr3,
      _MatlGroup3Text.bezei                                                   as mvgr3x,

      // ---------- Item: quantities, weights, volumes ----------
      // Sign inversion for credit/return items (SHKZG set)
      vbap.vrkme                                                              as vrkme_va,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case when vbap.shkzg = '' then vbap.kwmeng
           else                     vbap.kwmeng * -1
      end                                                                     as kwmeng,

      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case when vbap.shkzg = '' then vbap.klmeng
           else                     vbap.klmeng * -1
      end                                                                     as klmeng,

      vbap.zieme,

      @Semantics.quantity.unitOfMeasure: 'ZIEME'
      vbap.zmeng,

      vbap.meins                                                              as meins_va,

      // Weight is expressed in the weight unit (GEWEI), not the sales unit
      vbap.gewei,

      @Semantics.quantity.unitOfMeasure: 'GEWEI'
      case when vbap.shkzg = '' then vbap.ntgew
           else                     vbap.ntgew * -1
      end                                                                     as ntgew_va,

      // Volume is expressed in the volume unit (VOLEH), not the sales unit
      vbap.voleh                                                              as voleh_va,

      @Semantics.quantity.unitOfMeasure: 'VOLEH_VA'
      case when vbap.shkzg = '' then vbap.volum
           else                     vbap.volum * -1
      end                                                                     as volum_va,

      // ---------- Item: amounts ----------
      vbap.waerk                                                              as waerk_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      case when vbap.shkzg = '' then vbap.netwr
           else                     vbap.netwr * -1
      end                                                                     as netwr_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      case when vbap.shkzg = '' then vbap.mwsbp
           else                     vbap.mwsbp * -1
      end                                                                     as mwsbp_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      vbap.kzwi1                                                              as kzwi1_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      vbap.kzwi2                                                              as kzwi2_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      vbap.kzwi3                                                              as kzwi3_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      vbap.kzwi4                                                              as kzwi4_va,

      @Semantics.amount.currencyCode: 'WAERK_VA'
      vbap.kzwi5                                                              as kzwi5_va,

      // ---------- Business data: item value, else header item '000000' ----------
      case when _Vbkd.pltyp  <> '' then _Vbkd.pltyp  else _Vbkd2.pltyp  end   as pltyp,
      case when _Vbkd.kdgrp  <> '' then _Vbkd.kdgrp  else _Vbkd2.kdgrp  end   as kdgrp,
      case when _Vbkd.bzirk  <> '' then _Vbkd.bzirk  else _Vbkd2.bzirk  end   as bzirk,
      case when _Vbkd.empst  <> '' then _Vbkd.empst  else _Vbkd2.empst  end   as empst,
      case when _Vbkd.bstkd  <> '' then _Vbkd.bstkd  else _Vbkd2.bstkd  end   as bstkd,
      case when _Vbkd.bsark  <> '' then _Vbkd.bsark  else _Vbkd2.bsark  end   as bsark,
      case when _Vbkd.zterm  <> '' then _Vbkd.zterm  else _Vbkd2.zterm  end   as zterm_va,
      case when _Vbkd.lcnum  <> '' then _Vbkd.lcnum  else _Vbkd2.lcnum  end   as lcnum,
      case when _Vbkd.abssc  <> '' then _Vbkd.abssc  else _Vbkd2.abssc  end   as abssc,
      case when _Vbkd.traty  <> '' then _Vbkd.traty  else _Vbkd2.traty  end   as traty,
      case when _Vbkd.inco1  <> '' then _Vbkd.inco1  else _Vbkd2.inco1  end   as inco1_va,
      case when _Vbkd.inco2  <> '' then _Vbkd.inco2  else _Vbkd2.inco2  end   as inco2_va,
      case when _Vbkd.trmtyp <> '' then _Vbkd.trmtyp else _Vbkd2.trmtyp end   as trmtyp,

      // Date fields use the initial-date literal, not an empty string
      case when _Vbkd.prsdt <> '00000000' then _Vbkd.prsdt
           else                                _Vbkd2.prsdt
      end                                                                     as prsdt_va,

      case when _Vbkd.fkdat <> '00000000' then _Vbkd.fkdat
           else                                _Vbkd2.fkdat
      end                                                                     as fkdat_va,

      case when _Vbkd.bstdk <> '00000000' then _Vbkd.bstdk
           else                                _Vbkd2.bstdk
      end                                                                     as bstdk,

      _Vbkd2.valtg                                                            as valtg_va,

      // ---------- Custom append fields (replace with your own names) ----------
      vbak.zz_driver_code,
      _Driver.drivercode                                                      as driver_code_master,

      vbak.zz_vehicle_1,
      _VehicleText.veh_text                                                   as vehicle_1_text,
      vbak.zz_vehicle_2,
      _VehicleText2.veh_text                                                  as vehicle_2_text,
      _Vehicle.veh_type                                                       as vehicle_1_type,
      _Vehicle.ergei                                                          as vehicle_1_unit,

      vbap.zz_loading_seq,
      vbap.zz_alloc_period,

      // ---------- IS-OIL nomination + license ----------
      _Nomination.nomtk                                                       as nomtk,

      vbap.oih_licin                                                          as oih_licin_va,
      _License.lictp                                                          as lictp,
      _License.lctxt                                                          as lctxt_va,
      _License.datab                                                          as datab_va,
      _License.datbi                                                          as datbi_va,

      // ---------- Preceding-document reference ----------
      // CASE on the preceding SD document category (VBAP-VGTYP domain value);
      // adapt the category to the flow you need to trace.
      case vbap.vgtyp when 'G' then vbap.vgbel else '' end                    as ref_document,

      concat(vbak.vbeln, vbap.posnr)                                          as xblnr
}

// TRVOG = '0' is the standard SAP domain value for a sales order
// (as opposed to quotation / contract / inquiry).
where vbak.trvog = '0'
