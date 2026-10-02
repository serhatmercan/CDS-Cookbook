# CLAUDE.md — CDS-Cookbook

Coding rules: CDSGuide's docs/CDS-Development-Rules.md (planned; until it exists, follow the existing recipes).

## Purpose and scope
- Pattern library of user-authored CDS and AMDP recipes, mainly S/4HANA
  on-premise, searched on demand. CDSGuide
  (https://github.com/serhatmercan/CDSGuide) is the structured route read
  front to back. Concepts are explained there and linked from here, not
  repeated; a recipe names only the trap it guards against.
- Keep classic `define view` and `extend view` next to `define view entity`;
  do not rewrite them into view-entity syntax for style.
- Out of scope: copied SAP source, real organisational or Customizing
  values, DCL roles (none shipped or invented), ABAP Cloud compatibility
  claims. ABAP-side technique links to ABAPGuide.
- `Standard/` holds notes on how an SAP artifact was consumed, not its DDL.

## Structure
- Folders `Standard/`, `Extension/`, `Custom/`, `AMDP/`, `Util/`; module
  subfolders use upper-case SAP abbreviations (`MM`, `BASIS`, `OG` for IS-OIL).
- Every file ends in `.abap` (CDS DDL, AMDP, ABAP or notes); only
  `Standard/ValueHelp.txt` is `.txt`.
- File name: SAP artifact name in SAP's spelling in `Standard/` and
  `Extension/`; Z object name in `Custom/ValueHelp/`; otherwise the
  mechanism or document (`Sum.abap`, `SD-Order.abap`).
- Start from the folder's `Template.abap`. Header: `====` rule, `Type`,
  `Context`, object key (`CDS`, `Extension` or `Class`), `Module`,
  `Business Object`, `----` rule, `Description`, optional sections
  (`Fields Added`, `Related CDS`, ...), closing `====`; wrap at 79 columns.
- `Standard/` notes use the key-column format of `Standard/Template.abap`;
  `Type`/`Context` default to `Standard/README.md`.
- Several objects in one file: separate with a `---` line, say "anthology"
  or "paired recipe" in `Type`, repeat annotations per block.
- New patterns get a row in the root README "Pattern Categories" table;
  value helps a `Standard/ValueHelp.txt` row (custom: `[PROJECT-LOCAL]`).

## Labels
- `Type` starts with `complete CDS`, `extension`, `table function`, `AMDP`,
  `ABAP snippet` or `reference snippet` (not activatable as shown), plus a
  qualifier in parentheses. `Context` is `reusable pattern`,
  `genericised enterprise pattern` or `SAP standard reference`.
- Exactly five lifecycle labels, shared with ABAPGuide and CDSGuide:
  `CURRENT / RECOMMENDED`, `CLASSIC BUT STILL RELEVANT`,
  `LEGACY / HISTORICAL REFERENCE`, `ABAP CLOUD / MODERN CONTEXT`,
  `VERSION-DEPENDENT`.
- Markdown: ``> **Lifecycle:** `LABEL`. <one or two sentences>`` and
  `> ⚠ **VERSION-DEPENDENT: <feature>.** <text>`. Recipe headers use the
  same wording: a `Lifecycle  : LABEL. <text>` line after `Context` and a
  `VERSION-DEPENDENT: <feature>` section. `P_` and `R_` artifacts always
  carry one; every classic `define view` and `extend view` recipe carries
  `CLASSIC BUT STILL RELEVANT`.
- Existing recipes and `Release note` blocks are aligned in the planned
  recipe pass.
- Must-read warnings are upper-case header sections (`SECURITY BOUNDARY`,
  `PRIVACY BOUNDARY - read before reusing`, `VERIFY BEFORE REUSE`).

## Code examples
- Comments: `//` in CDS DDL, `"` in ABAP; never mixed within one object.
  Markdown fences are `` ```abap ``; untagged only for plain-text trees.
- Placeholders: `ZSM_` plus an infix, upper case in CDS: `ZSM_I_` view,
  `ZSM_C_` custom entity, `ZSM_F_` table function, `ZSM_CL_` class,
  `ZSM_I_EXT_` extension, `ZSM_V_` SQL view (max. 16 characters; for
  append names verify in your system); append fields `ZZ_*`.
- Existing `ZSD_`, `ZMM_`, `ZPM_` names are not precedent. Renames are done
  per dependency chain in one commit; a rename never changes element aliases.
- Organisational and Customizing values become parameters marked
  `// configuration`; SAP domain-value literals are named as such.
- `#NOT_REQUIRED` is never presented as protection; `#CHECK` needs a DCL role.
- AMDP: restrict every client-dependent table by the client parameter;
  `APPLY_FILTER` only with a condition generated from validated ABAP input.
- Omit personal-data fields the pattern does not need, and say so.
- Fix defects in place and note the trap; keep aliases, comments and field
  order. Never leave knowingly broken syntax.

## Links
- Recipes reference other files by repo-root path as plain text
  (`AMDP/Class.abap`) under `Related CDS` or `Related`. Markdown uses
  relative links only (`[Standard/README.md](Standard/README.md)`).
- For version questions link the ABAP Keyword Documentation:
  https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm
- External links are limited to official SAP documentation (help.sap.com,
  ABAP Keyword Documentation) and the sibling guides in github.com/serhatmercan.
