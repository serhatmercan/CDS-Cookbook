# CDS Cookbook — Practical SAP CDS & AMDP Patterns

A searchable SAP CDS and AMDP pattern library for experienced SAP developers — built for
**lookup**, not for step-by-step learning. You arrive knowing what you need (a filtered path
expression, a conditional aggregate, a table function with a recursive CTE, a plant-dependent
value help), find the pattern, and adapt it.

```
Standard/  how SAP standard CDS artifacts are consumed, by module
Custom/    custom view entities, value helps, custom-entity + query-provider pairs
Extension/ CDS view extensions, virtual elements, SADL exits
AMDP/      CDS table functions + their SQLScript implementations
Util/       reusable building blocks: joins, aggregation, parameters, value helps
```

## Scope & Provenance

- **Everything here is user-authored** — examples the author wrote, and reference notes the author
  took while building them.
- **`Standard/` does not contain copied SAP source.** Those files are notes on *how a standard
  artifact was consumed*: the working element subset, the association and join shape, the filter
  shape. See [`Standard/README.md`](Standard/README.md).
- **SAP standard names are referenced as dependencies and interfaces.** Entity names, element
  names, data elements and annotation vocabulary belong to SAP.
- **The custom examples are genericised enterprise patterns** distilled from practical S/4HANA
  development. Customer-specific field vocabulary, organisational scope and Customizing values are
  deliberately removed; custom append fields appear under neutral `ZZ_*` names. What remains is
  the structure worth reusing.
- **Mainly S/4HANA on-premise oriented.** Classic CDS and classic extensions are intentionally
  represented, because that is what on-premise projects use.
- **Not official SAP documentation.** Verify against SAP Help and your own system.

## Highlights

- **AMDP / SQLScript table functions** — window functions (`RANK`, `ROW_NUMBER`), `STRING_AGG`,
  CTEs, a **recursive CTE** for hierarchy traversal, `APPLY_FILTER` with an explicit trust
  boundary, HANA date functions, and client-correct joins throughout.
- **Standard CDS usage references** across 12 modules (MM, SD, PM, QM, FI, PP, PS, EWM, MD, HR,
  BASIS, plus IS-OIL/TSW).
- **Custom view entities** — text-table associations, item/header fallback, conditional
  aggregation, parameters, anti-joins via `IS NULL`.
- **Extensions** — classic `extend view` appends across five modules, analytics query extensions,
  **virtual elements with SADL exit classes** (read + filter).
- **Value-help patterns** — `additionalBinding`, `localConstant`, `distinctValues`, fuzzy search,
  plus a DDIC-key → value-help **index**.
- **Order → delivery → invoice chain** — three views that model a real document-flow projection.
- **Custom entity + query provider** — when the result set cannot be expressed in SQL.

## Guide vs Cookbook

[**CDSGuide**](https://github.com/serhatmercan/CDSGuide) is the structured route: concepts in
order, syntax explained, a learning and engineering reference you read front to back.
**CDS Cookbook** is the lookup route: production-shaped patterns you search, copy and adapt when
you already know what you are doing. Same subject, opposite reading mode — and the AMDP,
virtual-element and query-provider material here has no counterpart in the guide.

## Pattern Categories

Organised by **mechanism**, which is usually how you search:

| Mechanism | Where to look |
|---|---|
| Associations, filtered paths (`[1: … ]`), joins | `Standard/**`, `Custom/SD`, `Util/LeftOuterJoin.abap` |
| Aggregation & grouping | `Util/Max.abap`, `Util/Min.abap`, `Util/Sum.abap`, `Standard/PM`, `Standard/MM` |
| Parameters (`$parameters`) | `Util/Parameters.abap`, `Custom/ValueHelp/ZSM_I_USER_STATUS_VH.abap`, `AMDP/Function.abap` |
| Session variables, client handling | `Standard/**` (`$session.system_language`), `AMDP/**` (client parameter) |
| Extensions & appends | `Extension/**` |
| Virtual elements & SADL exits | `Extension/PM/C_ObjPgMaintOrderAndOperation.abap`, `Extension/PM/C_RSHMaintSchedSmltdOp.abap`, `Util/Class.abap` |
| Value helps | `Custom/ValueHelp/**`, `Util/ValueHelp.abap`, `Standard/ValueHelp.txt` |
| Table functions & AMDP | `AMDP/Function.abap` (contracts), `AMDP/Class.abap` (SQLScript) |
| Custom entity + query provider | `Custom/Implementation/**` |

## Repository Map

| Path | Contents |
|---|---|
| `Standard/<MODULE>/` | **User-authored reference notes on SAP standard CDS artifacts; not SAP source.** See `Standard/README.md` |
| `Standard/ValueHelp.txt` | DDIC key field → CDS value-help entity index |
| `Custom/SD/` | Order → delivery → invoice chain (genericised) |
| `Custom/ValueHelp/` | Custom value helps + a consumption-annotation snippet |
| `Custom/Implementation/` | Custom entity and its query-provider class |
| `Extension/<MODULE>/` | CDS view extensions; two files pair an extension with its exit class |
| `AMDP/` | `Function.abap` = table-function contracts, `Class.abap` = SQLScript implementations |
| `Util/` | Reusable building blocks |
| `User/` | User master reporting view (privacy boundary documented) |
| `List.abap` | Loose ABAP SQL snippet |

Most complete artifacts and mixed examples carry a short Type: and Context: line; for Standard/, the folder README carries the default.

## Find a Pattern

- **By module** — `Standard/<MODULE>` or `Extension/<MODULE>`.
- **By CDS entity name** — repo search or `grep` for the name; files are named after the artifact.
- **By field or association** — search the SAP field (`SalesOrganization`) or association
  (`_SalesDocumentItem`); names recur across files.
- **By business term** — `Delivery`, `Invoice`, `Nomination`, `Inspection`, `Maintenance`.
- **By mechanism** — see the table above; or grep an annotation (`@Semantics.quantity`,
  `virtualElementCalculatedBy`, `additionalBinding`, `STRING_AGG`, `WITH RECURSIVE`).
- **For a value help** — start at [`Standard/ValueHelp.txt`](Standard/ValueHelp.txt).

Files use the `.abap` extension whatever they contain (CDS DDL, AMDP, ABAP, notes) so syntax
highlighting stays consistent. CDS DDL files use `//` comments; genuine ABAP files use `"`.

## Compatibility / Lifecycle

- Examples span several on-premise S/4HANA / ABAP generations. Classic `define view` and classic
  `extend view` appends are kept on purpose alongside `define view entity`.
- The existence and release status of SAP standard objects **varies by release, Support Package
  and installed industry solution**. An `I_`, `C_`, `R_` or `P_` name alone is not a promise that
  the artifact is a released API in your system — `P_` and `R_` are private / restricted-use
  layers, and files referencing them say so.
- Release-sensitive features are flagged in the file that uses them (view entities, table
  functions, recursive CTEs, virtual elements, extension mechanisms, client-handling annotations).
- **No ABAP Cloud compatibility is claimed.** These patterns use direct table access, classic
  views, classic appends and function-module calls.
- Always validate against your target system before reuse.

## Adaptation & Security Notes

- These are **patterns, not drop-in solutions**. Adapt names, scope and types to your model.
- **Organisational and Customizing values are intentionally genericised.** Where a filter is
  needed, the file shows where to add your own instead of shipping one installation's values.
- **Authorization is your design decision.** `@AccessControl.authorizationCheck: #NOT_REQUIRED`
  means no check is applied. `#CHECK` only takes effect when a DCL role exists — with no
  applicable role it protects nothing. This repository ships no DCL roles and does not invent any.
- **Dynamic SQL and dynamic filters need a trusted boundary.** The `APPLY_FILTER` recipe in
  `AMDP/Class.abap` documents this explicitly: the condition must be *generated* from structured,
  validated ABAP selection input — never a raw condition string from a consumer.
- **Do not project personal data just because the source has it.** Several examples deliberately
  omit email, phone, tax and identity fields, and say so.

## Contributing

Small, focused, reversible changes:

1. One example (or one closely related group) per commit/PR.
2. Don't touch unrelated examples in the same change.
3. **Fix genuine technical defects; don't rewrite working code for style.** Preserve existing
   aliases, comments and field ordering otherwise.
4. Never leave knowingly broken syntax in place as "the example" — fix it and note the trap.
5. Keep the folder-by-module structure, and set `Type:` / `Context:` on new files.
6. Reference snippets are welcome and don't need to be activatable — label them as such.

## Related Guides

| Guide | Focus |
|---|---|
| [ABAPGuide](https://github.com/serhatmercan/ABAPGuide) | ABAP language and techniques, classic to modern |
| [CDSGuide](https://github.com/serhatmercan/CDSGuide) | ABAP CDS, structured route through both generations |
| **CDS-Cookbook** (this repository) | CDS and AMDP pattern library |
| [GWGuide](https://github.com/serhatmercan/GWGuide) | SAP Gateway: SEGW and OData V2 |
| [UIGuide](https://github.com/serhatmercan/UIGuide) | SAPUI5 and Fiori control and pattern reference |
| [JSGuide](https://github.com/serhatmercan/JSGuide) | Plain JavaScript and browser APIs |
| [PYGuide](https://github.com/serhatmercan/PYGuide) | Python reference with verified outputs |

## Author

**Serhat Mercan** — SAP BTP & AI Technical Lead | Generative AI for SAP | ABAP & SAP Fiori/UI5

- LinkedIn: [serhat-mercan](https://www.linkedin.com/in/serhat-mercan/)
- E-mail: serhatmercan94@gmail.com
- GitHub: [serhatmercan](https://github.com/serhatmercan)

## License

Released under the [MIT License](LICENSE).

**Scope:** the MIT licence covers this repository's own examples, notes and documentation. It
grants no rights over SAP-owned names, APIs, artifacts, data models or other intellectual property
referenced by the examples — those remain SAP's, and being visible in an SAP system does not make
them redistributable.
