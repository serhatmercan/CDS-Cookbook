@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Information'
define root view entity ZSD_I_ORDER
  as select from vbak
    inner join   vbap                            on vbak.vbeln             = vbap.vbeln
    association [0..1] to vbkd       as _Vbkd    on _Vbkd.vbeln       	   = $projection.vbeln_va 
                                                and _Vbkd.posnr       	   = $projection.posnr_va 
    association [0..1] to vbkd       as _Vbkd2   on _Vbkd2.vbeln      	   = $projection.vbeln_va 
                                                and _Vbkd2.posnr      	   = '000000'
    association [0..1] to vbpa       as _Vbpa    on _Vbpa.vbeln       	   = $projection.vbeln_va
                                                and _Vbpa.parvw       	   = 'WE'
                                                and _Vbpa.posnr       	   = '000000'
    association [0..1] to kna1       as _Kna1    on _Kna1.kunnr 	         = $projection.kunag             
    association [0..1] to oigd       as _Oigd    on _Oigd.zdtckno     	   = $projection.zz1_drivertcno_sdh
    association [0..1] to t173t      as _t173t   on _t173t.vsart	         = $projection.vsart             
                                                and _t173t.spras      	   = 'T'
    association [0..1] to tvakt      as _Tvakt   on _Tvakt.auart      	   = $projection.auart
                                                and _Tvakt.spras      	   = 'T'
    association [0..1] to tvkot      as _Tvkot   on _Tvkot.vkorg      	   = $projection.vkorg
                                                and _Tvkot.spras      	   = 'T'
    association [0..1] to tvtwt      as _Tvtwt   on _Tvtwt.vtweg      	   = $projection.vtweg
                                                and _Tvtwt.spras      	   = 'T'
    association [0..1] to tvkbt      as _Tvkbt   on _Tvkbt.vkbur	         = $projection.vkbur
                                                and _Tvkbt.spras      	   = 'T'
    association [0..1] to tvgrt      as _Tvgrt   on _Tvgrt.vkgrp	         = $projection.vkgrp
                                                and _Tvgrt.spras      	   = 'T'
    association [0..1] to oigv       as _Oigv    on _Oigv.vehicle     	   = $projection.zz1_tasitnumarasi_sdh
    association [0..1] to oigvt      as _Oigvt   on _Oigvt.vehicle    	   = $projection.zz1_tasitnumarasi_sdh
                                                and _Oigvt.language   	   = 'T'
    association [0..1] to oigvt      as _Oigvt2  on _Oigvt2.vehicle   	   = $projection.zz1_tasitnumarasi2_sdh
                                                and _Oigvt2.language  	   = 'T'
    association [0..1] to tvagt      as _Tvagt   on _Tvagt.abgru		       = $projection.abgru
                                                and _Tvagt.spras      	   = 'T'
    association [0..1] to tvm1t      as _Tvm1t   on _Tvm1t.mvgr1		       = $projection.mvgr1
                                                and _Tvm1t.spras      	   = 'T'
    association [0..1] to tvm2t      as _Tvm2t   on _Tvm2t.mvgr2		       = $projection.mvgr2
                                                and _Tvm2t.spras      	   = 'T'
    association [0..1] to tvm3t      as _Tvm3t   on _Tvm3t.mvgr3		       = $projection.mvgr3
                                                and _Tvm3t.spras      	   = 'T'
    association [0..1] to oijnomi    as _Oijnomi on _Oijnomi.docnr		   = $projection.vbeln_va
                                                and _Oijnomi.docitm		   = $projection.posnr_va
                                                and _Oijnomi.delind        is initial
    association [0..1] to oihl       as _Oihl    on _Oihl.licin		       = $projection.oih_licin_va

{
  key vbak.vbeln                                                                                                       as vbeln_va,
  key vbap.posnr                                                                                                       as posnr_va,
      vbak.trvog,
      vbak.vbtyp,
      case vbak.vbtyp
        when 'C' then 'Order'
        when 'H' then 'Refund'
        else 'Other'
      end                                                                                                              as vbtypx,
      vbak.lifsk,
      vbak.bstnk,
      vbap.abgru,
      _Tvagt.bezei                                                                                                     as abgrux,
      vbak.audat,
      vbak.vdatu,
      vbak.kunnr                                                                                                       as kunag,
      concat(_Kna1.name1, _Kna1.name2)                                                                                 as kunagx,
      vbak.vkorg,
      _Tvkot.vtext                                                                                                     as vkorgx,
      vbak.vtweg,
      _Tvtwt.vtext                                                                                                     as vtwegx,
      vbak.vkbur,
      _Tvkbt.bezei                                                                                                     as vkburx,
      vbak.vkgrp,
      _Tvgrt.bezei                                                                                                     as vkgrpx,
      vbak.erdat                                                                                                       as erdat_va,
      vbak.erzet                                                                                                       as erzet_va,
      vbak.ernam                                                                                                       as ernam_va,
      vbak.knumv                                                                                                       as knumv_va,
      vbak.autlf,
      vbak.gsber,
      vbak.bname,
      vbak.cmpsk,
      vbak.auart,
      _Tvakt.bezei                                                                                                     as auartx,
      vbap.shkzg                                                                                                       as shkzg_va,
      vbap.werks,
      vbap.vstel                                                                                                       as vstel_va,
      vbap.prodh,
      vbap.matnr,
      vbap.arktx                                                                                                       as maktx,
      vbap.mvgr1,
      vbap.mvgr2,
      vbap.mvgr3,
      vbap.kzwi1                                                                                                       as kzwi1_va,
      vbap.kzwi2                                                                                                       as kzwi2_va,
      vbap.kzwi3                                                                                                       as kzwi3_va,
      vbap.kzwi4                                                                                                       as kzwi4_va,
      vbap.kzwi5                                                                                                       as kzwi5_va,
      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case 
        when vbap.shkzg is initial then vbap.kwmeng 
        else -vbap.kwmeng 
      end                                                                                                              as kwmeng,
      @Semantics.quantity.unitOfMeasure: 'ZIEME'
      vbap.zmeng,
      vbap.zieme,
      vbap.vrkme                                                                                                       as vrkme_va,
      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case when vbap.shkzg is initial then vbap.klmeng 
           else -vbap.klmeng end                                                                                       as klmeng,
      vbap.meins                                                                                                       as meins_va,
      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case 
        when vbap.shkzg is initial then cast(vbap.ntgew as abap.quan(11,0)) 
        else -cast(vbap.ntgew as abap.quan(11,0)) 
      end                                                                                                              as ntgew_va,
      vbap.gewei,
      @Semantics.quantity.unitOfMeasure: 'VRKME_VA'
      case 
        when vbap.shkzg is initial then cast(vbap.volum as abap.quan(13,0)) 
        else -cast(vbap.volum as abap.quan(13,0)) 
      end                                                                                                              as volum_va,
      vbap.voleh                                                                                                       as voleh_va,
      vbap.waerk                                                                                                       as waerk_va,
      @Semantics.amount.currencyCode: 'WAERK_VA'
      case 
        when vbap.shkzg is initial then vbap.netwr 
        else -vbap.netwr 
      end                                                                                                              as netwr_va,
      @Semantics.amount.currencyCode: 'WAERK_VA'
      case when vbap.shkzg   is initial     then vbap.mwsbp   else -vbap.mwsbp end                                     as mwsbp_va,
      case when _Vbkd.pltyp  is not initial then _Vbkd.pltyp  else _Vbkd2.pltyp end                                    as pltyp,
      case when _Vbkd.prsdt  is not initial then _Vbkd.prsdt  else _Vbkd2.prsdt end                                    as prsdt_va,
      case when _Vbkd.fkdat  is not initial then _Vbkd.fkdat  else _Vbkd2.fkdat end                                    as fkdat_va,
      case when _Vbkd.kdgrp  is not initial then _Vbkd.kdgrp  else _Vbkd2.kdgrp end                                    as kdgrp,
      case when _Vbkd.bzirk  is not initial then _Vbkd.bzirk  else _Vbkd2.bzirk end                                    as bzirk,
      case when _Vbkd.empst  is not initial then _Vbkd.empst  else _Vbkd2.empst end                                    as empst,
      case when _Vbkd.bstkd  is not initial then _Vbkd.bstkd  else _Vbkd2.bstkd end                                    as bstkd,
      case when _Vbkd.bstdk  is not initial then _Vbkd.bstdk  else _Vbkd2.bstdk end                                    as bstdk,
      case when _Vbkd.bsark  is not initial then _Vbkd.bsark  else _Vbkd2.bsark end                                    as bsark,
      case when _Vbkd.zterm  is not initial then _Vbkd.zterm  else _Vbkd2.zterm end                                    as zterm_va,
      case when _Vbkd.lcnum  is not initial then _Vbkd.lcnum  else _Vbkd2.lcnum end                                    as lcnum,
      case when _Vbkd.abssc  is not initial then _Vbkd.abssc  else _Vbkd2.abssc end                                    as abssc,
      case when _Vbkd.traty  is not initial then _Vbkd.traty  else _Vbkd2.traty end                                    as traty,
      case when _Vbkd.inco1  is not initial then _Vbkd.inco1  else _Vbkd2.inco1 end                                    as inco1_va,
      case when _Vbkd.inco2  is not initial then _Vbkd.inco2  else _Vbkd2.inco2 end                                    as inco2_va,
      case when _Vbkd.trmtyp is not initial then _Vbkd.trmtyp else _Vbkd2.trmtyp end                                   as trmtyp,
      _Kna1.telf1,
      _Kna1.stcd1,
      _Kna1.stcd2,
      _Kna1.ktokd,
      vbap.vsart_ana                                                                                                   as vsart,
      _t173t.bezei                                                                                                     as vsartx,
      _Oigd.first_name,
      _Oigd.last_name,
      _Oigd.drivercode,
      _Oigv.ergei,
      @Semantics.quantity.unitOfMeasure: 'MEINS_VA'
      case when vbap.meins is not initial then $projection.klmeng end                                                  as sipton,
      case $projection.audat when 'Z120' then $projection.audat when 'Z124' then '' end                                as vdatu_va,
      case vbap.vgtyp when 'G' then vbap.vgbel end                                                                     as zthbl,
      case vbap.vgtyp when 'G' then vbap.vdatu_ana end                                                                 as zthem,
      _Vbkd2.valtg                                                                                                     as valtg_va,
      vbap.lgort                                                                                                       as lgort_va,
      concat(vbak.vbeln,vbap.posnr)                                                                                    as xblnr,
      _Tvm1t.bezei                                                                                                     as mvgr1x,
      _Tvm2t.bezei                                                                                                     as mvgr2x,
      _Tvm3t.bezei                                                                                                     as mvgr3x,
      vbak.cmgst,
      _Oigv.srfxnr                                                                                                     as tasaracno,
      _Oigv.veh_id                                                                                                     as vehid,
      _Oijnomi.nomtk                                                                                                   as nomtk,
      _Oihl.lictp,
      vbap.oih_licin                                                                                                   as oih_licin_va,
      _Oihl.lctxt                                                                                                      as lctxt_va,
      _Oihl.datab                                                                                                      as datab_va,
      _Oihl.datbi                                                                                                      as datbi_va
}
where
  vbak.trvog = '0' // Order 
