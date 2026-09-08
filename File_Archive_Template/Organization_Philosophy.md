# File Archive Organization — Reference

Goal: consistent placement, fast retrieval, and easy handoff. Categories define *what* a document is; subfolders define *how* it's shared or sliced.

> **Rule for Claude:** Before renaming, moving, or discussing file names for anything inside this File Archive, **always read this document first**. The naming conventions, folder taxonomy, and placement rules here are the single source of truth. Do not rename files from memory or convention assumptions — load and follow these rules every time.

> **Before you start:** this file ships with a generic starting taxonomy and a handful of illustrative (fictional) examples. Read it once, adjust the category list and tables to fit your own household or use case, then treat it as the single source of truth going forward — every rule you establish after that should get logged in the Change Log at the bottom, not just remembered.

---

## Category Semantics

Adjust this table to fit your situation — add, rename, split, or drop categories. The starting set below covers a typical household well; the "Placement Rule" column matters more than the exact category names.

| Category | What It Represents | Includes (examples) | Placement Rule |
|---|---|---|---|
| Identity | Legal proof of who you are | Passport, national ID, driver's license, Social Security/national ID number, marriage certificate, police certificate | If it proves who you are, it belongs here regardless of issuer. |
| Immigration | Permission to enter, stay, or leave a country | Visas, entry/exit records, residency applications, residency ID cards, customs declarations | If losing it affects where you can legally live or travel. Decide up front whether a residency card counts as Identity or Immigration for your situation, and write that decision down here as a rule, not a one-off judgment call. |
| Health | Medical state and care | Diagnoses, labs, imaging, prescriptions, national/private health-insurance admin | If a doctor would care about it, it belongs here. |
| Insurance (Non-Health) | Risk-transfer contracts | Auto, home, umbrella, liability | If it limits financial damage from adverse events. |
| Legal | Binding agreements and authority | Trusts, wills, power of attorney, contracts, notarized documents | If it creates or modifies legal obligations. |
| Finance | Money, assets, obligations | Investments, retirement, banks, loans, taxes | If it affects net worth, cash flow, or taxes. |
| Home | Physical living space | Leases, utilities, HOA, maintenance, management fees | If it changes when you move homes. |
| Work | Employment history | Employers, pay stubs/tax forms, contracts, resume, credentials | If it only matters because you worked somewhere. |
| Family | Person-centric documents (non-primary household) | Parents/grandparents, children | If the organizing axis is a person, not a topic. See Family Override Rule below. |
| Personal | Non-critical reference | Travel, manuals, recipes, hobbies, entertainment, product manuals/receipts | If losing it is annoying but not dangerous. |
| Security | Digital security keys and credentials | Disk-encryption recovery keys, 2FA backup codes | If it protects access to digital systems. |
| Individual | Personal non-family, non-work self | Goals, driving records | If it's about you as a person outside of work or family context. |

---

## Subfolder Semantics & Usage

| Subfolder Pattern | Used In | Purpose | Rules |
|---|---|---|---|
| By Person (Name) | Family, Identity, Health | Group documents tied to a specific individual | Use each person's preferred name consistently. Do not duplicate across categories. |
| Joint | Finance, Legal, Home, Health | Documents that apply to multiple people collectively | Use when no single person is primary. Prefer over duplication. |
| By Authority / Institution | Health, Finance, Work, Immigration | Cluster documents issued by the same entity | Stable issuers only (e.g., your health insurer, your bank). |
| By Year (YYYY) | Finance, Health, Work, Home | Chronological slicing for volume-heavy categories | Calendar year only. Avoid multi-year ranges. |
| By Property / Asset | Home, Finance | Tie documents to a physical or financial asset | One folder per asset or address. **Suggested naming:** `Property_City_State` (domestic) or `Property_City_CountryCode` (international) — use your postal service's state codes domestically and ISO 3166-1 alpha-2 country codes internationally (double-check the code you think is right — some are counterintuitive). The full pattern should always include the property identifier, not just a bare city/state tag. |
| By Project / Event | Legal, Immigration | Temporary grouping for a bounded process | Collapse or archive once complete. |
| Inbox / Staging | Any | Temporary holding for unclassified files | Must be emptied during cleanup passes. |

---

## File Naming Conventions

### Format

- Use `Title_Case_With_Underscores` for all filenames. No camelCase, no spaces.
- Every word starts with a capital letter except for minor prepositions (of, for, and, to) which may be lowercase.
- Acronyms stay uppercase: e.g. `MRI`, `IRS`, `HOA` — add your own recurring acronyms here as they come up.

### Dates

- All dates use `YYYYMMDD` (8 digits) or `YYYYMM` (6 digits) format.
- Dates are always **prefixed** — they come first in the filename.
- Example: `20250421_Alex_Checkup_Annual_Physical_Riverside_Clinic.pdf`
- Never use month names (January, April, etc.) in filenames. Convert to numeric.
- Never embed dates mid-name or as a suffix, **except for the documented exceptions below** — a mid-name date is only acceptable when it encodes information genuinely distinct from the prefix (see the mortgage-interest-statement and lease examples below). Log any new exception you establish here, the same way.
- Watch for common date typos: transposed digits, wrong century.

**Exception pattern — mid-name date that's genuinely distinct information:** e.g. a mortgage-interest statement is mailed the January after the year it covers, so the prefix (mailing date) and a mid-name tax year it covers are never the same digit and both carry real information: `202501_Property_Mortgage_Interest_Statement_2024.pdf`. Test before adding a new exception like this: does the mid-name date say something the prefix doesn't already say? If it just restates the prefix's year, drop it.

**Exception pattern — a document spanning a date range (e.g. a lease):** prefix with the range's own start date, and carry the end date mid-name as `_Through_YYYYMMDD`, e.g. `20250601_Property_Lease_Agreement_Through_20270531.pdf`. This is a formal, scoped exception to "no mid-name dates" — document any similar range-spanning document type you add the same way.

**Exception pattern — a whole-year document with no natural month/day** (an annual planning document, a multi-year compilation): use `YYYY07` (July) as the date prefix rather than a bare year or an arbitrary anchor month, so it still sorts correctly against everything else. Pick one anchor month and apply it consistently once you decide.

### Entertainment / one-off events

- Format: `YYYYMMDD_Venue_Event`
- The date is the **event date** (performance, screening), not the purchase date.
- Venue is the geographic location, at landmark level (e.g. `Riverside_Theater`), not the specific internal hall.
- Event is the show, film, or performance name.
- Example: `20211102_Riverside_Theater_A_Winters_Tale.pdf`

### Person Names

- Pick one preferred/informal name per person and use it in filenames everywhere.
- **Exception:** legal documents (trusts, wills, power of attorney, healthcare directives) use each person's full legal name, since that's what the document itself uses.
- Since files typically also live under person-named subfolders, the person prefix in the filename is for searchability, not hierarchy.

### Extensions

- Every file must have a file extension. No extensionless files.

### Shortcut Files

- Shortcut filenames (`.lnk`, Google Drive links) are prefixed with `_` (underscore) to visually separate them from primary files.
- **NEVER rename, move, or modify files that start with `_`.** These are Drive shortcut/link files managed by the sync app. Touching them will create duplicates and corrupt the Drive structure. Do not flag them as violations during audits.
- `.gdoc` and `.gsheet` files are **primary files**, not shortcuts. Do not prefix them with `_`, even though they technically link to Drive. Only files that point to another file's canonical home within the archive are considered shortcuts.
- **File size and page count are not evidence against shortcut status.** A `_`-prefixed Drive link file can be large and open as a full multi-page document — that's the link resolving to the real file, not a sign it's misfiled primary content. Do not open, OCR, or otherwise inspect `_`-prefixed files to second-guess whether they're "really" shortcuts — the underscore alone is the answer. Never flag or propose moving them.

---

## Name Preferences & Identity

Keep a small table here mapping each household member's preferred/informal name to their full legal name, plus a one-line note on any exception. Example pattern:

| Preferred Name | Legal Name | Notes |
|---|---|---|
| [Preferred name] | [Full legal name] | Use the preferred name everywhere except legal docs |
| [Child's name] | [Child's name] | Child — all docs go under `Family/[Child]/` |

---

## Family Override Rule

Documents that are *only* about a child or a parent/grandparent go under `Family/` regardless of what category they would normally belong to — a checkup for a child stays in `Family/[Child]/`, not `Health/`.

This does **not** apply to the primary household members (however many adults your household's documents are mostly about) — their documents follow the normal category rules.

**Scoping clarification:** the override is scoped to documents that are *only* about the Family-tracked person. If a document also covers a primary household member (e.g. a joint household record listing everyone), the normal topical category takes precedence over Family, even though a child happens to be named in it too.

### Family Subfolders

Add one subfolder per person or sub-group as documents accumulate — this list doesn't need to be exhaustive in advance. Example pattern:

- `[Parent_Side_A]` — one parent/grandparent side
- `[Parent_Side_B]` — the other parent/grandparent side
- `[Child_1]`, `[Child_2]` — children
- `[Parent_Side]/Joint` — documents about that pair collectively (a shared marriage certificate, etc.) rather than either individually, matching the `Joint` subfolder pattern used elsewhere.

New family subfolders can be added as new documents warrant it. Same applies to subfolders within any category — add one when a person or entity accumulates enough documents to deserve its own grouping, following the existing subfolder patterns above rather than inventing a new structure each time.

---

## Institution Naming

Keep a table here of the correct, consistent name for each institution you deal with, once you notice inconsistent spellings creeping in. Example pattern:

| Correct Name | Not |
|---|---|
| [Institution's actual name] | [Common misspelling or inconsistent variant] |

### Known Regional / Brand Names (Do Not Flag as Typos)

If you deal with brand names, product names, or local-language terms that look like typos to a naming audit but aren't, list them here so they don't get repeatedly flagged. Example pattern:

| Name in Filename | What It Is |
|---|---|
| [Brand or product name] | [One-line explanation of what it is and why the spelling is correct] |

### Known Brand Stylizations (Do Not Split — Institution Naming Exceptions)

Some institution/brand names are widely-recognized single-token trademarks where splitting into `Title_Case_With_Underscores` would read as *wrong* rather than clearer. List those here so they're not flagged as camelCase violations. A few universal examples to seed the idea:

| Name in Filename | Why It's Kept As-Is |
|---|---|
| MetLife | Established single-token trademark (Metropolitan Life) — "Met_Life" would be unrecognizable. |
| PayPal | Established single-token trademark — "Pay_Pal" reads as a typo, not a fix. |
| BitLocker | A specific product's own name — "Bit_Locker" isn't how it's ever written. |

Add your own as you find them — a vendor's own one-word stylization that *isn't* an established trademark (e.g. a small local business mashing two words together) should still be split per `Title_Case_With_Underscores` rather than added here.

---

## Core Principles

- Intent over format — classify by meaning, not file type.
- One primary home — no duplicates across categories.
- Stable anchors beat transient processes.
- Automation assists; humans decide.
- Optimize for future, stressed retrieval.

---

## Conflict Resolution

Pick a small, ordered list of "when two categories could both apply, this one wins" rules once you notice real conflicts — don't try to anticipate all of them up front. Starting suggestions, adjust freely:

- Identity > Immigration
- Legal > Finance
- Health > Insurance
- Home > Work
- If unclear: who would request this document?

---

## Philosophy on Shortcuts

- Shortcuts are allowed only as pointers, never as primary storage.
- A shortcut must always point to the canonical file, not a folder.
- Shortcuts may cross categories; files may not.
- If a shortcut becomes permanent, the underlying file is misplaced.
- Deleting a shortcut must never delete the source document.
- Shortcut filenames start with `_` to distinguish them from primary files.

---

## Intentional "Duplicates" — Do Not Merge or Delete

Some files that look like duplicates, splits, or redundant excerpts under a routine duplicates check are there on purpose. Keep a running list here of anything you've confirmed should stay split, so a future audit pass doesn't re-flag it. Common real-world cases to seed the idea:

- **ID document front/back scans (national ID, passport, driver's license) — keep front and back as separate files, per person.** Even though they're two sides of one physical document, the front and back often carry different sensitivity (a photo/name page vs. a page with a full national ID number or address) — fronts get shared for validation with third parties far more often than backs. Merging them removes the ability to share just the front.
- **A single-page excerpt of a longer legal document** (e.g. just the signature page or declaration page of a trust) kept separate from the full document, because institutions often ask for just that page rather than the whole thing.
- More generally: before merging or deleting anything that looks like a duplicate/split, consider whether the smaller piece might be kept separate specifically *because* it's meant to be shared or submitted on its own, distinct from the full/combined version. If in doubt, ask rather than merge.

---

## Trash / Pending Deletion

A `Trash/` folder at the File Archive root is for files that need deleting but can't be deleted directly during an automated pass.

- **On a scheduled/unattended run**, there's no one present to approve an interactive delete-permission prompt, so it can't be used. Instead, move the file into `Trash/` and append `FOR_DELETE` to its filename (e.g. `Trash/Old_Duplicate_Name_FOR_DELETE.pdf`). Review `Trash/` yourself and delete from there.
- **In an interactive session**, a direct delete (with your explicit approval) remains available. The `Trash/`+`FOR_DELETE` route is also fine to use interactively if you'd rather review before anything is removed.
- Don't use an in-place "mark for deletion" filename prefix scattered across category folders instead — centralize anything pending deletion in `Trash/`.

## Move & Rename Authority (AUTO / FLAG / NEVER)

Every file operation your automation performs (a renaming skill, an audit skill, or any subagent either dispatches) should fall into exactly one of three tiers. Writing this down explicitly — rather than leaving it as an implicit "ask when it feels risky" — is what keeps multiple automated runs (or multiple people) from quietly overstepping each other's authority.

**AUTO — do it, no flag, no asking.**
- Purely mechanical fixes: casing, date-format, acronym, spelling, and institution-naming corrections against the tables above.
- Renaming to match an established sibling precedent already documented in this file.
- Splitting a compilation per an already-documented precedent.
- Filing a file out of `Unsorted/` (or similar inbox/staging) into its correct category and name.
- **Moving or restructuring a file within its current top-level category** — a new subfolder, consolidating or renaming a subfolder, moving between subfolders of the *same* top-level category. "Parent" for this purpose means the top-level category, not the immediate containing folder. Moving all the way out to a different top-level category is not (see FLAG below).

**FLAG — write an explicit question and leave the file exactly where it is. Don't act until answered.**
- Moving a file to a *different* top-level category than its current one — a reclassification judgment call, not a tidy-up.
- Any rename that would change a file's apparent meaning, ownership, or purpose.
- Anything that would require inventing a new naming/placement rule not already documented in this file — see Precedent Confirmation below.

**NEVER — not even with a flag.**
- Touching `_`-prefixed shortcut files.
- A permanent delete outside the `Trash/`+`FOR_DELETE` path (see "Trash / Pending Deletion" above).
- Writing a new precedent into this document without your actual confirmation (see Precedent Confirmation below) — a plausible-sounding shortcut discovered mid-task doesn't get to quietly become "how things are done" just because no one objected in the moment.

### Precedent Confirmation

Any change to this document's naming, placement, or category rules — not a one-off file move, but something that will bind every future run — requires your explicit confirmation before it gets written here, the same tier of seriousness as routing a deletion through `Trash/` for review rather than running an unattended delete. A subagent or coordinator run that surfaces a plausible new rule mid-task should flag it (as an ask-the-user item, same as any other) rather than adopting it unilaterally, however reasonable it seems in the moment.

## Manual Cleanup Strategy

1. Open the document.
2. Identify the primary claim.
3. Place based on that claim.
4. Rename only to clarify intent — follow naming conventions above.
5. Do not refactor taxonomy mid-cleanup.

---

## Change Log

This document is a live reference, not a static one — every rule addition, naming precedent, or structural decision made about the archive should get logged here, so this file doesn't go stale the way an unmaintained README does. This is a fresh install — nothing logged yet. Your first entries will look something like:

`- YYYY-MM-DD: <what changed, and why — enough detail that a future run understands the reasoning, not just the outcome>`

---

*Clever systems decay. Obvious systems persist.*
