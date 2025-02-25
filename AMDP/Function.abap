@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientDependent: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
@EndUserText.label: 'Function AMDP'

define table function ZSM_F_AMOUNT
  with parameters p_bukrs : bukrs,
                  p_gjahr : gjahr 

returns {
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

define table function ZSM_F_NOMI_MATCH_PRM
  with parameters @Environment.systemField: #CLIENT
                  p_client  : abap.clnt,
                  p_nomtk   : oij_nomtk,
                  p_nomit   : oij_item
returns {
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
  with parameters @Environment.systemField: #CLIENT
                  p_client : abap.clnt
returns {
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
  with parameters @Environment.systemField: #CLIENT
                  p_client : abap.clnt

returns {
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

define table function ZSM_F_WORKING_DAYS
  with parameters @Environment.systemField: #CLIENT
                  p_client : abap.clnt,
                  p_fabkl  : fabkl

returns {
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
  with parameters @Environment.systemField: #CLIENT
                  p_client     : abap.clnt,
                  p_first_day  : abap.dats,
                  p_last_day   : abap.dats,
                  p_calendar   : fabkl
returns {
  Client   : abap.clnt;
  FirstDay : datum;
  LastDay  : datum;
  WorkDay  : int4;
}
implemented by method zsm_cl_amdp=>workdays_between;