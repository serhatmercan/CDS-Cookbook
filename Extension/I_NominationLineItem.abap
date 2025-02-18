@AbapCatalog.sqlViewAppendName: 'ZOG_V_EXT_NLI'
extend view I_NominationLineItem with ZOG_I_EXT_INOMINATIONLINEITEM
  association [0..1] to oijnomi as _Oijnomi on _Oijnomi.nomtk = $projection.nominationdoc 
                                           and _Oijnomi.nomit = $projection.nominationdocitem
{
  _Oijnomi.zz1_supalan_nim,
  _Oijnomi.zz1_tahlim_nim
}
