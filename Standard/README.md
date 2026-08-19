# Standard/ — Reference notes on SAP standard CDS artifacts

**These files are user-authored reference notes. They are not SAP source code.**

Every file in this folder describes **how an SAP standard CDS artifact was consumed** — which
elements were selected, which associations were used, what the join and filter shape looked like.
They are written in this repository's own note format, not in activatable DDL:

```
CDS         :   <the standard artifact this note is about>
Description :   <what it is>

Using       :   <how the author's own view selected from / joined / associated to it>
Fields      :   <the working subset of elements, with the author's aliases>
Where       :   <the author's filter shape>
Group By    :   <grouping, where the note shows an aggregation>

Module / Business Object / Common Use Cases / Related CDS / Notes / Type / Context
```

## What this means when you read a file here

| | |
|---|---|
| **Filename** | the SAP artifact the note is *about* — not the name of an object stored here |
| **`Using:`** | the author's consuming view's join/association — the data sources named there (`Vbrp`, `Ekpo`, `Bkpf`, `matdoc`, `$projection…`) belong to the consuming view |
| **`Fields:`** | a hand-picked working subset with the author's own aliases (`as Vbeln`, `as Meins`, `as Tplnr`) — not a reproduction of the artifact's element list |
| **`Where:` / aggregation** | the author's own logic |

Most files are therefore **fragments by design**. A missing `define view` is not a defect, and
these notes are not claimed to compile. Where a file *does* present a complete aggregation
pattern, its `Group By` is complete and consistent with its projection — that is marked in the
file's `Type` line.

## Provenance

No file in this folder reproduces SAP-delivered DDL. SAP entity names, element names, data
elements and annotation vocabulary are referenced as **dependencies and interfaces** — they remain
SAP's intellectual property, and the MIT licence on this repository covers only the author's own
notes and examples around them. See the root [README](../README.md#license).

## Scope and lifecycle

- Content is oriented to **S/4HANA on-premise**.
- Organisational and Customizing values (company codes, sales/purchasing organisations, document
  types, condition types, movement types, ledgers, calendars, status profiles) are **intentionally
  not hard-coded**. Where a note needs one, it says so and shows where to add your own.
- A name alone is not a release promise. `I_` does not mean "released API"; `C_` are consumption
  views; **`P_` and `R_` are private / restricted-use VDM layers** and carry an explicit
  `Release note`. Verify existence, release status and extensibility in your own system.
- Some artifacts require an **industry solution** (IS-OIL / TSW in `OG/`, EWM in `EWM/`) — niche,
  but standard SAP, not customer-specific.

## Also here

[`ValueHelp.txt`](ValueHelp.txt) — a DDIC key field → CDS value-help entity index (company code,
plant, storage location, unit of measure, currency, and the IS-OIL keys). The fastest lookup in
the repository. Rows marked `[PROJECT-LOCAL]` are custom artifacts that will not exist in your
system.

`Template.abap` — the note format above, empty.
