" ============================================================================
" Extension   : I_InspectionLot  (extend view ... with ZSM_I_EXT_IL)
" Module      : QM
" Business Object : Inspection Lot
" ----------------------------------------------------------------------------
" Description
"   Adds a status short text (Txt04) to the Inspection Lot view by resolving
"   the lot's active status (JEST) against the status text table for the
"   usage-decision-relevant statuses E0001/E0002.
"
" Fields Added
"   Txt04 - _Text.txt04, status short text for status E0001 (UD skipped) / E0002 (UD required)
"
" Associations Used
"   _Jest -> JEST/status association  on Objnr = StatusObject, Inact = '' (active status only)
"   _Text -> status text               on Stsma = StatusProfile, Spras = 'T', Estat in (E0001, E0002)
"
" Common Use Cases
"   - Inspection lot list/reporting: show whether usage decision is required/skipped as text
" ============================================================================

@AbapCatalog.sqlViewAppendName: 'ZSM_V_EXT_'

@EndUserText.label: 'I_InspectionLot Extend View'

extend view I_InspectionLot with ZSM_I_EXT_IL

  association [1] to _Jest
    on  _Jest.Objnr = $projection.StatusObject
    and _Jest.Inact = ''

  association [0..1] to _Text
    on  _Text.Stsma = $projection.StatusProfile
    and Spras       = 'T'
    and (_Text.Estat = 'E0001' or _Text.Estat = 'E0002')

{
  _Text.txt04 as Txt04
}
