" ============================================================================
" Type        : ZSD_I_DELIVERY  (root view entity)
" Module      : SD (with IS-OIL license fields)
" Business Object : Outbound Delivery
" ----------------------------------------------------------------------------
" Description
"   Delivery header + item (LIKP/LIPS) view, associated back to the
"   originating sales order (ZSD_I_ORDER) via VGBEL/VGPOS, with ship-to
"   customer name, storage location description, and IS-OIL license info.
"
" Associations Used
"   _Ord   -> zsd_i_order   on vbeln_va = vgbel_vl and posnr_va = vgpos_vl
"   _Kna1  -> kna1          on kunnr = kunwe (ship-to)
"   _T001l -> t001l         on werks/lgort (storage location text)
"   _Oihl  -> oihl          on licin = oih_licin_vl
"
" Common Use Cases
"   - Middle link in the Order -> Delivery -> Invoice reporting chain
"
" Related CDS
"   ZSD_I_ORDER, ZSD_I_INVOICE
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Delivery Information'

define root view entity ZSD_I_DELIVERY
  as select from likp

    inner join   lips on lips.vbeln = likp.vbeln

  association [0..1] to zsd_i_order as _Ord
    on  _Ord.vbeln_va = $projection.vgbel_vl
    and _Ord.posnr_va = $projection.vgpos_vl

  association [0..1] to kna1        as _Kna1
    on _Kna1.kunnr = $projection.kunwe

  association [0..1] to t001l       as _T001l
    on  _T001l.werks = $projection.werks
    and _T001l.lgort = $projection.lgort

  association [0..1] to oihl        as _Oihl
    on _Oihl.licin = $projection.oih_licin_vl

{
  key likp.vbeln                       as vbeln_vl,

      lips.posnr                       as posnr_vl,
      lips.vgbel                       as vgbel_vl,
      lips.vgpos                       as vgpos_vl,
      lips.bwtar                       as bwtar_vl,
      lips.werks,
      lips.lgort,
      _T001l.lgobe                     as lgobe,
      likp.vstel                       as vstel_vl,
      likp.lfart,
      likp.inco1                       as inco1_vl,
      likp.inco2                       as inco2_vl,
      likp.podat,
      likp.potim,
      likp.kunnr                       as kunwe,
      concat(_Kna1.name1, _Kna1.name2) as kunwex,
      lips.pdsta,
      likp.wadat_ist,
      likp.erzet                       as erzet_vl,
      likp.erdat                       as erdat_vl,
      likp.ernam                       as ernam_vl,
      lips.lfimg                       as lfimg_vl,
      lips.vrkme                       as vrkme_vl,
      lips.ntgew                       as ntgew_vl,
      lips.gewei                       as gewei_vl,
      lips.volum                       as volum_vl,
      lips.voleh                       as voleh_vl,
      lips.meins                       as meins_vl,
      lips.mtart,
      lips.lgmng                       as lgmng_vl,
      _Oihl.lictp,
      lips.oih_licin                   as oih_licin_vl,
      _Oihl.lctxt                      as lctxt_vl,
      _Oihl.datab                      as datab_vl,
      _Oihl.datbi                      as datbi_vl,
      lips.wbsta,
      likp.wbstk,
      likp.wauhr,

      case
        when $projection.auart is null and _Ord.inco1_va = 'DAP' then concat(_Ord.inco1_va, lips.pdsta)
        else '    '
      end                              as dapgos,

      _Ord.vbeln_va,
      _Ord.posnr_va,
      _Ord.trvog,
      _Ord.vbtyp,
      _Ord.Vbtypx,
      _Ord.lifsk,
      _Ord.bstnk,
      _Ord.abgru,
      _Ord.abgrux,
      _Ord.audat,
      _Ord.vdatu,
      _Ord.kunag,
      _Ord.kunagx,
      _Ord.vkorg,
      _Ord.vkorgx,
      _Ord.vtweg,
      _Ord.vtwegx,
      _Ord.vkbur,
      _Ord.vkburx,
      _Ord.vkgrp,
      _Ord.vkgrpx,
      _Ord.erdat_va,
      _Ord.erzet_va,
      _Ord.ernam_va,
      _Ord.knumv_va,
      _Ord.autlf,
      _Ord.gsber,
      _Ord.bname,
      _Ord.cmpsk,
      _Ord.zz1_drivertcno_sdh,
      _Ord.zz1_boruhattionay_sdh,
      _Ord.zz1_boruhattonaytanm_sdh,
      _Ord.zz1_sirano_sdh,
      _Ord.zz1_tasitnumarasi_sdh,
      _Ord.tasit1_text,
      _Ord.zz1_tasitnumarasi2_sdh,
      _Ord.tasit2_text,
      _Ord.auart,
      _Ord.auartx,
      _Ord.shkzg_va,
      _Ord.vstel_va,
      _Ord.zz1_allocationperiod_sdi,
      _Ord.prodh,
      _Ord.matnr,
      _Ord.maktx,
      _Ord.mvgr1,
      _Ord.mvgr2,
      _Ord.mvgr3,
      _Ord.kzwi1_va,
      _Ord.kzwi2_va,
      _Ord.kzwi3_va,
      _Ord.kzwi4_va,
      _Ord.kzwi5_va,
      _Ord.kwmeng,
      _Ord.vrkme_va,
      _Ord.klmeng,
      _Ord.meins_va,
      _Ord.ntgew_va,
      _Ord.gewei,
      _Ord.volum_va,
      _Ord.voleh_va,
      _Ord.waerk_va,
      _Ord.netwr_va,
      _Ord.mwsbp_va,
      _Ord.Pltyp,
      _Ord.prsdt_va,
      _Ord.fkdat_va,
      _Ord.kdgrp,
      _Ord.bzirk,
      _Ord.empst,
      _Ord.bstkd,
      _Ord.bstdk,
      _Ord.bsark,
      _Ord.zterm_va,
      _Ord.lcnum,
      _Ord.abssc,
      _Ord.traty,
      _Ord.inco1_va,
      _Ord.inco2_va,
      _Ord.trmtyp,
      _Ord.telf1,
      _Ord.stcd1,
      _Ord.stcd2,
      _Ord.ktokd,
      _Ord.vsart,
      _Ord.vsartx,
      _Ord.zdehlno,
      _Ord.first_name,
      _Ord.last_name,
      _Ord.drivercode,
      _Ord.zdteln1,
      _Ord.zdteln2,
      _Ord.zdingilsayisi,
      _Ord.ergei,
      _Ord.zdara,
      _Ord.ztoleransyba,
      _Ord.toleransli_yba_b,
      _Ord.zdolumtipi,
      _Ord.tankerdt,
      _Ord.sipton,
      _Ord.vdatu_va,
      _Ord.zthbl,
      _Ord.zthem,
      _Ord.valtg_va,
      _Ord.zmeng,
      _Ord.zieme,
      _Ord.lgort_va,
      _Ord.mvgr1x,
      _Ord.mvgr2x,
      _Ord.mvgr3x,
      _Ord.zgross_ton,
      _Ord.nomtk
}
