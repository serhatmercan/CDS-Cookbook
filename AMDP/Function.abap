// ============================================================================
// Type       : table function (anthology - several artifacts in one file)
// Context    : reusable pattern
// CDS        : ZSM_F_*  (CDS table function definitions)
// Module     : cross-application
// ----------------------------------------------------------------------------
// Description
//   The CDS "define table function" contracts (parameters + result structure)
//   implemented by the AMDP methods in ZSM_CL_AMDP.
//   See AMDP/Class.abap for the SQLScript implementations.
//
// Anthology note
//   This file collects SEVERAL independent table functions, separated by
//   "---". It is a reference file, NOT one activatable object: create one DDL
//   source per function in your system. Each block below repeats its own
//   complete annotation header, because CDS annotations bind to a single
//   artifact and would otherwise apply only to the first function.
//
// Client-handling pattern used throughout this file
//   Every client-dependent function here uses ONE coherent pattern:
//     - @ClientHandling.type: #CLIENT_DEPENDENT
//     - the client element is the FIRST element of the returned structure and
//       is typed with the built-in dictionary type abap.clnt
//     - an input parameter typed abap.clnt annotated @Environment.systemField:
//       #CLIENT, which the runtime fills implicitly on SELECT
//     - the implementation restricts every client-dependent table with that
//       parameter and includes the client column in every join
//
//   Release note: some releases also offer
//   @ClientHandling.algorithm: #SESSION_VARIABLE, where the implementation
//   must read the client from SESSION_CONTEXT instead of from a parameter. Do
//   not mix the two mechanisms in one function, and check which combination
//   your target release supports before copying. The annotation
//   @ClientDependent is NOT the client annotation for table functions and is
//   deliberately not used here.
//
// Related
//   AMDP/Class.abap
// ============================================================================

@AccessControl.authorizationCheck: #NOT_REQUIRED
// Access control note: table functions are usually consumed by a view that
// carries the access control. #NOT_REQUIRED means no check is applied here;
// it is not a protection statement.

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Quantity list per accounting document'

define table function ZSM_F_QUANTITY_LIST
  with parameters
    @Environment.systemField: #CLIENT
    p_client : abap.clnt,

    p_bukrs  : bukrs,
    p_gjahr  : gjahr,
    p_langu  : spras

  returns
  {
    Client       : abap.clnt;
    Ledger       : rldnr;
    CompanyCode  : bukrs;
    FiscalYear   : gjahr;
    Document     : belnr_d;
    TaxCode      : mwskz;

    // Comma-separated list of "quantity + unit text" per document, produced
    // by STRING_AGG. This is a text aggregation, not an amount.
    QuantityList : abap.char(255);
  }

  implemented by method zsm_cl_amdp=>get_quantity_list;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Latest change document date per table key'

define table function ZSM_F_CHANGE_DATE
  with parameters
    @Environment.systemField: #CLIENT
    p_client       : abap.clnt,

    p_object_class : cdobjectcl,
    p_table_name   : tabname,
    p_field_name   : fieldname

  returns
  {
    Client     : abap.clnt;
    ObjectID   : cdobjectv;
    TableKey   : cdtabkey;
    ChangeDate : abap.dats;
    ChangeTime : abap.tims;
  }

  implemented by method zsm_cl_amdp=>get_change_date;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Material + description by generated filter condition'

define table function ZSM_F_MATERIAL
  with parameters
    @Environment.systemField: #CLIENT
    p_client           : abap.clnt,

    p_langu            : spras,

    // SECURITY BOUNDARY - read AMDP/Class.abap before reusing this.
    // This must be a WHERE fragment GENERATED on the ABAP side from
    // structured selection/range input. A raw condition string taken from a
    // consumer must never reach APPLY_FILTER.
    p_filter_condition : abap.char(1000)

  returns
  {
    Client       : abap.clnt;
    Material     : matnr;
    MaterialName : maktx;
  }

  implemented by method zsm_cl_amdp=>get_material;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Nomination demand / offer schedule lines with pegging'

define table function ZSM_F_NOMI_MATCH
  with parameters
    @Environment.systemField: #CLIENT
    p_client : abap.clnt,

    p_nomtk  : oij_nomtk,
    p_nomit  : oij_item

  returns
  {
    Client                     : abap.clnt;
    NominationDoc              : oij_nomtk;
    NominationDocItem          : oij_item;
    PeggingID                  : oij_pegid;
    NominationScheduleType     : oij_sityp;
    NominationReferenceDocType : oij_docind;
  }

  implemented by method zsm_cl_amdp=>get_nomi_match;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Row-numbered nomination match result'

define table function ZSM_F_NOMI_ROWS
  with parameters
    @Environment.systemField: #CLIENT
    p_client : abap.clnt

  returns
  {
    Client                     : abap.clnt;
    NominationDoc              : oij_nomtk;
    NominationDocItem          : oij_item;
    PeggingID                  : oij_pegid;
    NominationScheduleType     : oij_sityp;
    NominationReferenceDocType : oij_docind;
    RowNo                      : abap.int4;
  }

  implemented by method zsm_cl_amdp=>get_nomi_rows_no;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Working days between price validity dates'

define table function ZSM_F_RISK_DOCS
  with parameters
    @Environment.systemField: #CLIENT
    p_client   : abap.clnt,

    // Factory calendar is configuration - pass it in, do not hard-code it.
    p_calendar : fabkl

  returns
  {
    Client         : abap.clnt;
    DocNo          : knumv;
    DocItemNo      : kposn;
    DocItemGuid    : guid;
    PriceBeginDate : datum;
    PriceEndDate   : datum;
    WorkingDays    : abap.int4;
  }

  implemented by method zsm_cl_amdp=>get_risk_docs;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Technical objects assigned to a user, incl. sub-hierarchy'

define table function ZSM_F_TECHNICAL_OBJECT
  with parameters
    @Environment.systemField: #CLIENT
    p_client : abap.clnt,

    p_bname  : xubname

  returns
  {
    Client            : abap.clnt;
    UserName          : xubname;
    Plant             : werks_d;
    FunctionalLocation: tplnr;
    HierarchyLevel    : abap.int4;
  }

  implemented by method zsm_cl_amdp=>get_technical_object;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Working-day flags per calendar date'

define table function ZSM_F_WORKING_DAYS
  with parameters
    @Environment.systemField: #CLIENT
    p_client     : abap.clnt,

    p_calendar   : fabkl,

    // Bounded on purpose: an unbounded calendar scan is not a reusable default.
    p_date_from  : abap.dats,
    p_date_to    : abap.dats

  returns
  {
    Client             : abap.clnt;
    CalendarDate       : datum;
    FactoryCalendar    : fabkl;
    MonthFirstDate     : datum;
    MonthLastDate      : datum;
    WorkingDaysInMonth : abap.int4;
    IsWorkingDay       : abap.int4;
  }

  implemented by method zsm_cl_amdp=>get_working_days;

// ----------------------------------------------------------------------------
---

@AccessControl.authorizationCheck: #NOT_REQUIRED

@ClientHandling.type: #CLIENT_DEPENDENT

@EndUserText.label: 'Working days between two dates'

define table function ZSM_F_WORKDAYS_BETWEEN
  with parameters
    @Environment.systemField: #CLIENT
    p_client   : abap.clnt,

    p_date_from : abap.dats,
    p_date_to   : abap.dats,
    p_calendar  : fabkl

  returns
  {
    Client      : abap.clnt;
    DateFrom    : datum;
    DateTo      : datum;
    WorkingDays : abap.int4;
  }

  implemented by method zsm_cl_amdp=>workdays_between;
