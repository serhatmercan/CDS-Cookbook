CLASS ZSM_CL_AMDP DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      if_amdp_marker_hdb.

    CLASS-METHODS:
      get_risk_docs     FOR TABLE FUNCTION zsm_f_risk_docs,
      get_working_days  FOR TABLE FUNCTION zsm_f_working_days,
      workdays_between  FOR TABLE FUNCTION zsm_f_workdays_between.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ZSM_CL_AMDP IMPLEMENTATION.
  METHOD get_risk_docs BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zsm_i_risk_docs.
    RETURN SELECT DISTINCT p_client                                                      as Client,
                           docno                                                         as DocNo,
                           docitemno                                                     as DocItemNo,
                           docitemguid                                                   as DocItemGuid,
                           pricebegintime                                                as PriceBeginTime,
                           pricebegindate                                                as PriceBeginDate,
                           priceendtime                                                  as PriceEndTime,
                           priceenddate                                                  as PriceEndDate,
                           workdays_between( 'PI', pricebegindate, priceenddate ) + 1    as WorkingDay
                      FROM zsm_i_risk_docs;
  ENDMETHOD.

  METHOD get_working_days BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING i_calendardate.
    t_calendar = SELECT p_client                                                                                      as Client,
                        ID.calendardate                                                                               as CalendarDate,
                        p_fabkl                                                                                       as FactoryCalendar,
                        ID.firstdayofmonthdate                                                                        as MonthFirstDate,
                        last_day( ID.calendardate )                                                                   as MonthLastDate,
                        workdays_between( p_fabkl, ID.firstdayofmonthdate, add_months( ID.firstdayofmonthdate,1  ) )  as WorkingDaySmonth,
                        workdays_between( p_fabkl, ID.calendardate, dats_add_days(ID.calendardate,1,'INITIAL')  )     as IsWorkingDay
                   FROM i_calendardate                                                                                as ID;

    RETURN SELECT Client,
                  CalendarDate,
                  FactoryCalendar,
                  MonthFirstDate,
                  MonthLastDate,
                  WorkingDaySmonth,
                  IsWorkingDay
             FROM :t_calendar
            WHERE IsWorkingDay <> 0;
  ENDMETHOD.

  METHOD workdays_between BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    RETURN SELECT p_client    as Client,
                  p_first_day as FirstDay,
                  p_last_day  as LastDay,
                  workdays_between( p_calendar, p_fday, p_lday ) + 1 as Workday
             FROM dummy;
  ENDMETHOD.
ENDCLASS.