@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
@EndUserText.label: 'Function AMDP'

define table function ZSM_F_RISK_DOCS
  with parameters @Environment.systemField: #CLIENT
                  p_client : abap.clnt

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
implemented by method
  zsm_cl_amdp=>get_risk_docs;

---

define table function ZSM_F_WORKING_DAYS
  with parameters @Environment.systemField: #CLIENT
                  p_client : abap.clnt,
                  p_fabkl  : fabkl

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
implemented by method
  zsm_cl_amdp=>get_working_days;

---

define table function ZSM_F_WORKDAYS_BETWEEN
  with parameters @Environment.systemField: #CLIENT
                  p_client     : abap.clnt,
                  p_first_day  : abap.dats,
                  p_last_day   : abap.dats,
                  p_calendar   : fabkl
returns
{
  Client   : abap.clnt;
  FirstDay : datum;
  LastDay  : datum;
  WorkDay  : int4;
}
implemented by method
  zsm_cl_amdp=>workdays_between;