# CDS Cookbook — SAP CDS Cookbook & Reference Library

A personal, searchable collection of practical **SAP CDS View** examples pulled from real SAP projects — Standard views, Custom views, Extensions, Value Helps, AMDP implementations, and reusable snippets.

This is **not** a tutorial. It doesn't explain CDS syntax or SAP concepts. It's a reference you search when you already know what you're looking for and just need a working example.

## Purpose

- Skip searching through an SAP system (or SAP Help) for a CDS view's structure, associations, or fields.
- Find ready-to-adapt patterns for common SD/MM/PM/QM/FI/... requirements.
- Keep a personal record of Extensions, Value Helps, and AMDP implementations built across projects.

## Intended audience

SAP developers and consultants (ABAP/CDS, RAP, Fiori backend) who already know CDS and want a fast-lookup reference — not people learning CDS from scratch. For a learning-oriented walkthrough, see the author's separate [ABAP Guide](https://github.com/serhatmercan) and CDS Guide repositories.

## Folder structure

```
/
├── Standard/          SAP standard CDS views, grouped by module
│   ├── BASIS/
│   ├── EWM/
│   ├── FI/
│   ├── HR/
│   ├── MD/
│   ├── MM/
│   ├── OG/
│   ├── PM/
│   ├── PP/
│   ├── PS/
│   ├── QM/
│   └── SD/
│
├── Custom/            Custom (Z*) CDS views
│   ├── Implemantation/    Custom CDS + AMDP implementation class pairs
│   ├── SD/                 Custom SD views
│   └── ValueHelp/           Custom value help views
│
├── Extension/         CDS view extensions (extend view / DDIC extension includes), grouped by module
│   ├── MM/ OG/ PM/ QM/ SD/
│
├── AMDP/              Standalone AMDP class/function examples
│
├── User/              User- and authorization-related CDS views
│
├── Util/              Reusable building blocks: joins, aggregations, parameters, value helps
│
├── List.abap          Loose SQL/ABAP snippets not tied to a specific CDS view
│
├── LICENSE
└── README.md
```

Each folder is organized by SAP module (BASIS, MM, SD, PM, QM, FI, HR, PS, EWM, MD, OG, PP) so examples from the same functional area stay together.

## How to search examples

- **By module** — browse `Standard/<MODULE>` or `Extension/<MODULE>` (e.g. `Standard/SD` for sales documents, `Standard/MM` for purchasing).
- **By CDS view name** — use GitHub's repo search or `grep`/`Ctrl+F` for the view name (e.g. `I_SalesDocument`, `I_PurchaseOrder`). Most files are named after the primary CDS view they contain.
- **By field or association** — search for the SAP field name (e.g. `SalesOrganization`) or association name (e.g. `_SalesDocumentItem`) across the repo; CDS views commonly reuse the same field and association names.
- **By keyword** — search for a business term (e.g. `Delivery`, `Invoice`, `Nomination`) since filenames and descriptions are kept close to SAP terminology.

## Naming conventions

| Type | Convention | Example |
|---|---|---|
| SAP standard CDS view | Original SAP name (`I_`, `C_`, `R_`, `P_`, `A_`) | `I_SalesDocument.abap` |
| Custom CDS view | `Z*` namespace, prefixed per project convention | `ZSD_I_ORDER.abap` |
| Custom Value Help | `ZSM_I_*_VH` | `ZSM_I_VEHICLE_VH.abap` |
| CDS Extension | Named after the extended standard view | `C_SalesDocumentItemDEX_1.abap` |
| Template files | `Template.abap` in each category folder | `Standard/Template.abap` |

Files use the `.abap` extension regardless of whether they contain CDS DDL, DCL, AMDP, or plain ABAP/SQL — this keeps syntax highlighting consistent across editors.

`Standard/Template.abap` and `Custom/ValueHelp/Template.abap` define the lightweight documentation header (`CDS` / `Description` / `Using` / `Fields` / `Where` / `Group`) used to annotate examples where useful. Applying it is optional and never a reason to rewrite an existing example's code.

## SAP versions

Examples are collected from S/4HANA on-premise projects. CDS syntax and available annotations vary by release and Support Package — where an example depends on a specific release feature, this is noted in the file itself. Always validate against your own system's CDS version before reuse.

## Contributing

This repository favors small, focused, reversible changes:

1. One example (or one closely related group of examples) per commit/PR.
2. Do not modify unrelated examples in the same change.
3. Preserve existing CDS code, aliases, comments, and field ordering — fix only genuine technical errors, not style.
4. Keep additions consistent with the existing folder-by-module structure.
5. New examples should be self-contained and runnable/adaptable on their own, without depending on other files in the repo.

## License

Released under the [MIT License](LICENSE).

## Contact

Serhat Mercan — [github.com/serhatmercan](https://github.com/serhatmercan)
