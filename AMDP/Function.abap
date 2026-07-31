" ============================================================================
" Table Functions : ZSM_F_*  (CDS table function definitions)
" Module      : N/A
" Business Object : N/A
" ----------------------------------------------------------------------------
" Description
"   Declares the CDS "define table function" signatures (parameters + result
"   structure) implemented by the AMDP methods in ZSM_CL_AMDP (see
"   AMDP/Class.abap).
"
" Functions
"   - ZSM_F_AMOUNT            : implemented by get_amount            - aggregated ACDOCA amounts per document
"   - ZSM_F_DATE              : implemented by get_date              - latest PR release change date/time
"   - ZSM_F_MATERIAL          : implemented by get_material          - material + description by selection option
"   - ZSM_F_NOMI_MATCH_PRM    : implemented by get_nomi_match_prm    - nomination demand/offer matching (parametrized)
"   - ZSM_F_NOMI_ROWS         : implemented by get_nomi_rows_no      - row-numbered nomination match result
"   - ZSM_F_RISK_DOCS         : implemented by get_risk_docs         - working days between price validity dates
"   - ZSM_F_TECHNICAL_OBJECT  : implemented by get_technical_object  - technical objects assigned to a user (with sub-hierarchy)
"   - ZSM_F_WORKING_DAYS      : implemented by get_working_days      - working-day flags per calendar date
"   - ZSM_F_WORKDAYS_BETWEEN  : implemented by workdays_between      - working days between two dates for a factory calendar
"
" Common Use Cases
"   - Parameter/result contract for AMDP-backed table functions, consumed from other CDS views
" ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientDependent: true

@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Function AMDP'

define table function ZSM_F_AMOUNT
  with parameters
    p_bukrs     : bukrs,
    p_gjahr     : gjahr

returns

{
  Client : abap.clnt;
  Rldnr  : rldnr;
  Bukrs  : bukrs;
  Gjahr  : gjahr;
  Belnr  : belnr_d;
  Mwskz  : mwskz;
  Amount : char255;
}

implemented by method zsm_cl_amdp=>get_amount;

---

define table function ZSM_F_DATE
returns

{
  Client   : abap.clnt;
  ObjectID : cdobjectv;
  Tabkey   : cdtabkey;
  Odate    : abap.dats;
  Otime    : abap.tims;
}

implemented by method zsm_cl_amdp=>get_date;

---

define table function ZSM_F_MATERIAL
  with parameters
    p_sel_opt   : abap.char(1000)

returns

{
  Client  : abap.clnt;
  Matnr   : matnr;
  Maktx   : maktx;
}

implemented by method zsm_cl_amdp=>get_material;

---

define table function ZSM_F_NOMI_MATCH_PRM
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt,

    p_nomtk     : oij_nomtk,
    p_nomit     : oij_item

returns

{
  Client                     : abap.clnt;
  NominationDocDQ            : oij_nomtk;
  NominationDocItemDQ        : oij_item;
  NominationDocOQ            : oij_nomtk;
  NominationDocItemOQ        : oij_item;
  NominationScheduleType     : oij_sityp;
  NominationReferenceDocType : oij_docind;
}

implemented by method zsm_cl_amdp=>get_nomi_match_prm;

---

define table function ZSM_F_NOMI_ROWS
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt

returns

{
  Client                      : mandt;
  NominationDocDQ             : oij_nomtk;
  NominationDocItemDQ         : oij_item;
  NominationDocOQ             : oij_nomtk;
  NominationDocItemOQ         : oij_item;
  NominationScheduleType      : oij_sityp;
  NominationReferenceDocType  : oij_docind;
  NominationScheduleTypeO     : oij_sityp;
  NominationReferenceDocTypeO : oij_docind;
  RowNo                       : abap.int4;
}

implemented by method zsm_cl_amdp=>get_nomi_rows_no;

---

define table function ZSM_F_RISK_DOCS
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt

returns

{
  Client         : abap.clnt;
  DocNo          : knumv;
  DocItemNo      : kposn;
  DocItemGuid    : guid;
  PriceBeginTime : cpet_firsttimestamp;
  PriceBeginDate : datum;
  PriceEndTime   : cpet_firsttimestamp;
  PriceEndDate   : datum;
  WorkingDay     : int4;
}

implemented by method zsm_cl_amdp=>get_risk_docs;

---

define table function ZSM_F_TECHNICAL_OBJECT
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt,

    p_bname     : xubname

returns

{
  Client : abap.clnt;
  Werks  : werks_d;
  Bname  : xubname;
  Tplnr  : tplnr;
}

implemented by method zsm_cl_amdp=>get_technical_object;

---

define table function ZSM_F_WORKING_DAYS
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt,

    p_fabkl     : fabkl

returns

{
  Client           : abap.clnt;
  CalendarDate     : datum;
  FactoryCalendar  : fabkl;
  MonthFirstDate   : datum;
  MonthLastDate    : datum;
  WorkingDaySmonth : abap.int4;
  IsWorkingDay     : abap.int4;
}

implemented by method zsm_cl_amdp=>get_working_days;

---

define table function ZSM_F_WORKDAYS_BETWEEN
  with parameters
    @Environment.systemField: #CLIENT
    p_client    : abap.clnt,

    p_first_day : abap.dats,
    p_last_day  : abap.dats,
    p_calendar  : fabkl

returns

{
  Client   : abap.clnt;
  FirstDay : datum;
  LastDay  : datum;
  WorkDay  : int4;
}

implemented by method zsm_cl_amdp=>workdays_between;
