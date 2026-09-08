---
tags: [system, meta, skills, file-archive]
last_updated: 2026-01-01
---

# File Renamer — Mandate

See [[00_Skills_Index]] for how this fits with the vault's other skills, and [[00_Reviewers_Index]] for how it relates to the scheduled reviews. This skill is invoked directly by name (interactively, or from a hand-off) — most often by [[File_Archive_Auditor_Mandate]], which hands it content-dependent renames and Living-Reference-drift syncs to execute. Fully self-contained: no shared protocol file the way the domain reviews share `_Shared_Review_Protocol.md`.

## Contents

- [[#Role and mandate]]
- [[#Step 1: Load the rules]]
- [[#Step 1b: Never touch _-prefixed files]]
- [[#Step 2: Determine the mode]]
- [[#Step 3: Read and identify the file]]
- [[#Step 4: Determine the correct name]]
- [[#Step 5: Determine the correct location]]
- [[#Step 6: Decide whether to act or ask]]
- [[#Step 7: Sync to Living Reference (Health, Identity, Legal & Finance documents only)]]
- [[#Step 7b: Update the lab-trends note (lab-bearing Health documents only)]]
- [[#Step 7c: Sync Finance documents to your Finance summary note]]

## Role and mandate

You are a file librarian for a personal document archive. Your job is to read a file's actual content, determine what it is, and figure out the correct name and location for it according to the archive's Organization Philosophy — then, for the domains that have one, keep the corresponding Living Reference note current so the archive being well-organized doesn't quietly drift out of sync with what Living Reference says.

## Step 1: Load the rules

Read `Organization_Philosophy.md` from the root of the File Archive. This is the single source of truth for naming conventions, date formats, folder taxonomy, and placement rules. If the file is missing, stop and tell the user — you cannot rename without it.

Pay special attention to:
- The folder taxonomy (what categories exist and what belongs in each)
- Naming conventions (Title_Case_With_Underscores, date prefix format, acronym rules)
- Person name preferences, per your own household's Person Names table (an everyday name vs. a legal name, if those differ — legal name in legal documents only)
- Any household-specific override rule for family-member documents (e.g. "all documents about a child or parent stay under Family/ regardless of topic")
- Whatever conflict-resolution hierarchy your Organization_Philosophy.md defines for overlapping categories
- Institution name standards
- The `Trash/` root folder and its `FOR_DELETE` suffix convention for files that need deleting but can't be deleted directly during an automated pass (see Step 6's splitting section below, and Organization_Philosophy.md's "Trash / Pending Deletion" section)
- **The "Move & Rename Authority (AUTO / FLAG / NEVER)" section** — the three-tier framing Step 6 below is built on. Read it before Step 6, not just Step 6's own summary of it.
- New subfolders can be added under any category whenever a person or entity accumulates enough documents to deserve its own grouping — add it following the existing subfolder patterns and record it directly in Organization_Philosophy.md rather than treating it as a question, unless the category/placement itself is ambiguous.

## Step 1b: Never touch `_`-prefixed files

Files and folders starting with `_` are Google Drive shortcut/link files — never rename, move, merge, or delete them, and never open/OCR them to "check" whether they're really shortcuts. They can legitimately be large, multi-page PDFs (the link resolving to real content) — size and page count are not evidence they're misfiled primary documents; see Organization_Philosophy.md's Shortcut Files section. If a batch or freshness hand-off includes a `_`-prefixed file, skip it.

## Step 2: Determine the mode

**Single-file mode**: The user points at a specific file or asks about one file. Go to Step 3.

**Batch mode**: The user asks to process a folder (like `Unsorted/` or a downloads folder). Get a listing of the folder, then run Step 3 for each file. Present all proposals together at the end.

## Step 3: Read and identify the file

Read the file's content to understand what it actually is. Your approach depends on file type:

- **PDFs**: Extract text with `pdftotext`. If the output is empty or whitespace-only, the PDF is image-based — use OCR (see below). Look for letterheads, institution names, dates, account numbers, document titles, and the type of document (statement, bill, letter, form, certificate, etc.).
- **Word docs / text files**: Read the content directly. Look for titles, headers, dates, and subject matter.
- **Spreadsheets**: Read the sheet names and first few rows. Identify what data it contains.
- **Images**: Look at the image. If it's a scan or photo of a document, identify the document type. If it's a personal photo, note subjects and context.
- **HTML files (browser-saved dumps)**: don't read these raw — see "Handling browser-saved HTML dumps" below and strip formatting cruft first.
- **Other files**: Use the `file` command to identify the type, then read what you can.

### Handling image-based PDFs (OCR fallback)

When `pdftotext` returns empty or whitespace-only output, the PDF contains scanned images rather than embedded text. Do not flag it as unreadable or ask the user — use OCR instead:

```python
import subprocess, tempfile, os

pdf_path = "/path/to/file.pdf"
with tempfile.TemporaryDirectory() as tmp:
    subprocess.run(['pdfimages', '-png', '-f', '1', '-l', '2', pdf_path, f'{tmp}/page'], check=True)
    imgs = sorted(os.listdir(tmp))[:2]
    for img in imgs:
        r = subprocess.run(['tesseract', f'{tmp}/{img}', 'stdout', '--psm', '3'],
                           capture_output=True, text=True)
        print(r.stdout[:600])
```

Key points:
- Only OCR the first 2 pages — enough to identify document type, institution, person, and date without wasting tokens on long documents.
- Both `pdfimages` and `tesseract` are available at `/usr/bin/` in the workspace.
- This applies to any image-based PDF: scanned receipts, tax software printouts, benefits mailers, notices in a non-English language, etc.
- If `tesseract` output is garbled (common on some non-Latin scripts even after orientation is fixed), fall back to viewing the extracted page image directly (vision) instead of trusting the OCR text — this matters especially for Step 7/7b/7c extraction, not just for identifying the file in this step. If a page image renders upside-down or mirrored, correct with `img.rotate(180).transpose(Image.FLIP_LEFT_RIGHT)` in PIL before viewing.
- If OCR output is still insufficient (truly unreadable scan), then ask the user.

### Handling browser-saved HTML dumps (strip formatting cruft first, and keep only the cleaned version)

Recognize one of these by: a `<!-- saved from url=... -->` comment near the top of the file, a sibling `<name>_files/` folder sitting next to it (fonts, `.js.download`, `.css` files), or simply being several MB for what should be a simple account page. These are typically "account activity" style dumps (brokerage/bank account summaries, statements viewed online and saved via the browser rather than downloaded as a PDF) and are routinely 90%+ CSS/JavaScript/inline-style/tracking-attribute noise wrapped around a small amount of real data.

**Never read one of these raw** — it wastes enormous amounts of context and buries the real content in framework markup. Instead, clean it first:

1. **Run the bundled cleaning script against the file** — it ships with the `file-renamer` skill at `scripts/strip_html.py` (the skill's base directory is printed as "Base directory for this skill" when it loads):
   ```bash
   python3 "<this skill's base directory>/scripts/strip_html.py" "<path to the .html file>" /tmp/cleaned.html
   ```
   Requires `beautifulsoup4` and `lxml` — both already available in the workspace; if missing, `pip install beautifulsoup4 lxml --break-system-packages`. See the script's own docstring (`python3 scripts/strip_html.py` with no args prints it) for exactly what it strips and how.
2. Read `/tmp/cleaned.html` for everything downstream — content identification in this step, and any Living Reference extraction in Step 7/7c.
3. **The cleaned version is what gets filed — not the raw original.** These HTML dumps exist purely as data sources for review tasks, not for their formatting, so there's no reason to keep the bloated raw version once it's cleaned. When you reach Steps 4-6 and know the correct name/date/place:
   - Write the **cleaned** HTML content to the final destination path (with the properly dated/named filename — still a `.html` extension).
   - Delete the raw original and its sibling `<name>_files/` asset folder — neither has standalone record value once the cleaned version is filed. See Step 6's deletion-handling note below (delete directly if possible; otherwise route through `Trash/` with `FOR_DELETE`, or the permission tool if interactive).
   - If the user wants a document's original formatting preserved, that's their choice to make by saving it as a PDF in the first place, not something to reconstruct from an HTML dump.
   - **This clean-and-refile process still runs through Step 6's normal act-vs-ask gate — it doesn't bypass it.** An HTML dump landing in `Unsorted/` gets cleaned, renamed, and filed automatically, same as any other Unsorted/ file. One that's already sitting in a category folder under a generic or wrong name is still governed by Step 6's same-parent/cross-parent split below — clean it to identify what it is and to know what to propose, but only auto-refile it if the move stays within its current top-level category.

From the content, extract these key pieces of information:
1. **What is this document?** (bank statement, medical bill, tax form, lease, photo, etc.)
2. **Who is it about?** (a tracked adult, a child, a parent, etc. — per your own household's tracked-people list)
3. **What institution/organization?** (use the standard name per the Philosophy)
4. **What date?** (the most relevant date — statement date, bill date, filing date, etc.)
5. **Any other distinguishing details?** (account type, claim number, property address, etc.)

## Step 4: Determine the correct name

Build the filename following the Organization Philosophy's conventions:

1. **Date prefix**: `YYYYMMDD_` or `YYYYMM_` depending on precision available. If no date is found in the content, omit the prefix and flag this for the user. For a live-status document with no printed date (an account dashboard, a membership status page), it's reasonable to use the capture/filing date as the prefix — note that assumption when reporting rather than presenting it as the document's own stated date.
2. **Descriptive body**: Use Title_Case_With_Underscores. The name should be specific enough that someone browsing the folder can tell what the file is without opening it. Include the institution name, person name (if relevant and not obvious from the folder), and document type.
3. **Acronyms**: Keep uppercase, per whatever your household treats as an acronym.
4. **Extension**: Preserve the original file extension.

**Examples of good names** (these are illustrative — always derive from actual content and Philosophy rules):
- `20250315_<Bank>_Checking_Statement.pdf`
- `20250201_<Insurer>_Premium_Invoice_<Person1>.pdf`
- `202503_<Brokerage>_IRA_Quarterly_Statement.pdf`
- `20250410_<Person2>_Passport_Renewal_Application.pdf`

## Step 5: Determine the correct location

Based on what the document is and the Philosophy's taxonomy, decide which folder it belongs in. Apply the rules in order:

1. Check any household-specific override rule first (e.g. a family-member override that routes children's/parents' documents to a shared folder regardless of topic).
2. Check conflict resolution rules — if it could fit multiple categories, the hierarchy decides.
3. Otherwise, place it in the category matching its primary purpose.
4. If a per-program/per-institution family file already exists for this kind of document (e.g. a shared file already holding everyone's screenshots for one loyalty program), follow that established pattern — merge new pages into the existing file rather than creating a parallel one, unless the existing convention is clearly per-person instead.
5. Check for an established precedent among sibling files before assuming the general rule applies uncontested — e.g. a tax-year source-document bundle might have an existing precedent of keeping a dependent's income documents bundled alongside the parents' own, because they're inputs to the parents' joint filing, not standalone records about the dependent. Follow an established precedent like this rather than re-deriving placement from the general rule alone; note in your report which precedent you followed.

Be specific about the subfolder path, not just the top-level category.

## Step 6: Decide whether to act or ask

The rules for when to auto-apply vs. ask depend on **where the file currently lives**, using the AUTO / FLAG / NEVER tiers defined in Organization_Philosophy.md's "Move & Rename Authority" section — read that section, this is just its application to this skill's specific job.

### Files in Unsorted/ — AUTO, handle automatically

Files in `Unsorted/` (or any inbox/downloads-style folder) are by definition unfiled. Rename and move them automatically based on what you found in their content. No need to ask unless you genuinely can't figure out what the file is (encrypted, empty, unreadable). After processing, report what you did: `Unsorted/old_name.pdf` → `Finance/Banking/20250315_<Bank>_Checking_Statement.pdf`

On a case-insensitive filesystem, do a two-step rename (rename to a temp name first, then to the target) to avoid collisions.

### Files already in a category folder — the same-parent/cross-parent split

If a file is already placed in a non-Unsorted directory, it was put there intentionally (even if the name is wrong). Three sub-cases:

**Move or restructure within the same top-level category (AUTO — no need to ask):** Moving a file between subfolders of the *same* top-level category in Organization_Philosophy.md's Category Semantics table — including creating a new subfolder, consolidating subfolders, or renaming the containing folder itself — is a tidy-up, not a reclassification. Proceed and report what you did. "Same parent" means the top-level category, not the immediate containing folder: a restructuring within a category (e.g. tidying a country-specific visa-application subfolder's naming) is same-parent (AUTO) as long as both paths stay under that same top-level category.

**Move to a different top-level category (FLAG — always ask):** Moving a file out of its current top-level category into a *different* one is a reclassification judgment call, not a tidy-up. Always ask (interactive), or follow the unattended-run fallback below. Present the proposal with your reasoning for why the file belongs elsewhere.

**Rename only (file is in the right folder but name is wrong):** Before auto-renaming, compare the old name and the new name. If the new name would change the **apparent meaning, ownership, or purpose** of the file — ask first. A name change that shifts who the document seems to be about, what type of document it is, or what it's for is not just cosmetic; the user may have named it that way deliberately.

Examples where you should ask (cross-parent move, or a meaning-changing rename):
- `Person1_Tax_Return.pdf` → `Person2_Tax_Return.pdf` (changes ownership)
- `Bank_Savings_Statement.pdf` → `Bank_Checking_Statement.pdf` (changes account type / purpose)
- `Medical_Bill.pdf` → `Insurance_Claim.pdf` (changes document type)
- a file that would cross top-level categories, even if the rename itself is otherwise clean

Examples where you can auto-rename or auto-move (same-parent, or purely cosmetic):
- `bank checking statement march.pdf` → `202503_Bank_Checking_Statement.pdf` (just formatting fixes)
- `20250315_bank_checking_Statement.pdf` → `20250315_Bank_Checking_Statement.pdf` (casing fix)
- `Bank Checking Statement 2025-03-15.pdf` → `20250315_Bank_Checking_Statement.pdf` (date format + spacing fix)
- a restructuring that stays within the same top-level category (just reorganized)

When asking, present it like:
```
📄 old_name.pdf (currently in Category/Subcategory/)
   Contents: [brief description of what you found in the file]
   Proposed name: YYYYMMDD_New_Name.pdf
   Proposed location: [same folder, or new path if moving]
   Why I'm asking: [what changed — ownership, purpose, cross-category move, etc.]
   
   Should I proceed, or would you like to adjust?
```

### Unattended runs: no one to ask

The FLAG rule above doesn't relax on a scheduled/unattended run — but there's no one present to answer it, the same problem the `Trash/`+`FOR_DELETE` convention solves for deletions. When a FLAG-tier case (a cross-parent move, or a meaning-changing rename) comes up with no one present:

- **Don't move or rename the file.** Leave it exactly where it is — an unconfirmed guess sitting in the wrong place is worse than a correctly-flagged file sitting where the user left it.
- **Write the proposal as an `[!agent-question]`** in `Living Reference/Archive_Index.md`'s "Open Filing Questions" section: `> [!agent-question]` / `> For [you]: <same proposal content as the interactive prompt above — current location, contents, proposed name/location, why you're asking>`. Check that section for an existing unaddressed question covering the same file before adding a duplicate.
- **Report it too** — don't rely on the inline flag alone to be the only record in your own run's output.
- A matching answer callout under that question is what authorizes the move — whichever skill next sees it (most likely `file-archive-audit`'s next sweep, or this skill on a later invocation) should execute it and remove both callouts, logging the resolution in `Archive_Index.md`.
- **In an interactive session, this fallback doesn't apply** — ask directly as above; that's still faster than round-tripping through a note.

### Never merge or delete these, regardless of location or how "duplicate" they look

- **ID document front/back scans** (national ID, passport, driver's license) — front and back stay as separate files, both per-person and in a joint-documents folder. Fronts are routinely shared for validation independently of backs, which carry more sensitive data. See Organization_Philosophy.md's "Intentional Duplicates" section before treating any front/back pair as a merge candidate.
- **Single-page excerpts of larger documents kept deliberately separate** — e.g. a single "page 1 of the trust" file, kept apart from the full trust document because institutions ask for just that one page (or the signature/title page) to open accounts or name a beneficiary. Check Organization_Philosophy.md's "Intentional Duplicates" list before deleting anything that looks like a redundant excerpt.

### How to actually delete a file once you've decided to

Whenever this skill calls for deleting a file (a split-out compilation original, a redundant HTML dump, a confirmed-duplicate merge candidate, etc.), try a plain `rm`/delete first. If that fails (commonly "Operation not permitted" on the Drive-backed archive folder):

- **Interactive session (user present):** call the file-delete permission tool for that path, then retry the delete. This is still the fastest path when someone can approve it.
- **Scheduled/unattended run (no one present to approve):** the permission tool will hang or fail with no one to respond to its prompt — don't use it. Instead, move the file into `Trash/` at the File Archive root and append `FOR_DELETE` to its filename (e.g. `Trash/Old_Compilation_Name_FOR_DELETE.pdf`). The user reviews `Trash/` and deletes from there themselves — see Organization_Philosophy.md's "Trash / Pending Deletion" section.

Either way, don't leave a file that should be deleted sitting untouched in its original location, and don't report back that deletion "isn't possible" — one of the two paths above always applies.

### Splitting multi-document PDFs into their component documents

Some files (especially compilations swept up by a hand-off or batch pass — e.g. a file named something like "Employment_Letters_History" or "Employment_Documents_Compilation") are actually several distinct documents concatenated into one PDF: different dates, different letters/forms/statements, sometimes for different purposes entirely. When you find one of these:

1. **Map document boundaries first, don't guess from the filename.** Read (or OCR) every page — at minimum enough of each page to see where letterhead/date/subject changes — before deciding where one document ends and the next begins. A run of pages that shares one continuous subject (e.g. a multi-page equity-offering packet with its annexes and signature pages) stays together as one document; don't over-split just because it's long.
2. **Check every resulting piece against files already filed nearby for duplicate/overlapping content** — not just similar filenames. Compilations built by re-scanning or re-exporting often re-capture a document (an offer letter, a severance agreement) that already has its own clean standalone file elsewhere in the same folder. Verify by comparing actual extracted text, not just document type — a partial/lower-quality scan of the same letter is still the same letter. If a split-out piece is a full or partial duplicate of a more complete file that already exists, drop it from the split rather than filing a second copy; keep the more complete/authoritative version. If a piece is genuinely new (e.g. a page that only exists in the compilation), file it as its own properly-named document.
3. **Use `pypdf`** (already available; `pip install pypdf --break-system-packages` if missing) to do the actual page-range extraction into separate files — read the source once with `PdfReader`, write each page range with a fresh `PdfWriter`.
4. **Date each split-out piece from its own content**, not the compilation's filename-implied range. If a specific piece's date can't be pinned down precisely (e.g. an illegible or blank signature-date field), use the best available anchor (e.g. a hire date explicitly stated elsewhere on the same form, or the tax year for a W-2-style form) and say so plainly when reporting — don't silently present an inferred date as if it were printed on the document.
5. **Delete the original compilation file** once its pieces are safely split out and (if applicable) duplicates dropped — don't leave the multi-document original sitting alongside its own split pieces. Follow "How to actually delete a file once you've decided to" above.

## Step 7: Sync to Living Reference (Health, Identity, Legal & Finance documents only)

If the file's final location (after Steps 4–6) is under a tracked person's Health or Identity subfolder, or under a joint-documents subfolder (affects a fact shared by more than one tracked person's Identity note — a marriage certificate, a joint ID/voter-registration scan — sync to every relevant person's note, not just one), or under an Immigration subfolder (if that applies to your household) and affects a status/expiry date already referenced in that person's Identity note, or under your Legal trust/estate-planning subfolder(s), or under your Finance Institutions/Net_Worth/Investments subfolders — check whether it should update the corresponding note in `Living Reference/` (a sibling folder to `File Archive`, not nested inside it).

This step exists because the archive being well-organized doesn't mean it's current — see [[00_README_Living_Reference_System]] for the full rationale. For Health, Identity, and Legal documents, follow the sync protocol below; for Finance documents, the extraction rubric is in Step 7c instead.

**Identity notes specifically — Renewal Eligible column and sort order.** Each `Identity_Summary_[Person].md`'s Currently Valid Documents table carries a **Renewal Eligible** column (computed from `Identity/_Reference/Renewal_Windows_Glossary.md` — look up the formula there, don't recompute from memory) and is kept **sorted ascending by that date, earliest first**, with no-expiry rows last. Whenever an edit adds a row, changes an existing row's Expires/Renewal Eligible date, or moves a row out to Superseded/Historical, re-sort the remaining table so it stays in that order — this is a mechanical reorder of dates already in the table, not a new judgment call. See `_Templates/Identity_Summary_Template.md` for the current column layout.

Legal documents (trust, wills, POAs, healthcare directives) are almost always joint — sync to your Legal joint summary note (see the `_Templates/Legal_Summary_Template.md` pattern), not a per-person note, unless the document is clearly about only one person's individual legal matter.

Finance documents (bank/brokerage statements, balance exports, investment/account records) are almost always joint too — sync to your Finance joint summary note (see `_Templates/Finance_Summary_Template.md`), which should have sections per owner (Trust/Joint, and one per tracked person) rather than needing separate per-person notes.

Skip this step entirely for:
- General Health or Identity items not clearly about one tracked person
- Purely administrative documents (itemized bills, payment receipts, insurance invoices) with no new clinical, document-status, or estate-plan-structure information
- Any Legal subfolder you've explicitly scoped out (e.g. vehicle titles, an unrelated litigation matter) — not currently tracked in Living Reference
- Tax filings, unless the document itself changes an already-tracked account's ownership or trust-titling status (e.g., a 1099 confirming trust titling) — routine annual tax filings (returns, W-2s, payroll calculations) don't feed your Finance summary note, which tracks accounts/net worth, not tax history
- Routine credit-card statements with no ownership change — a Finance summary note typically tracks credit cards for ownership/reference only, not as part of net worth (paid in full monthly), so there's no tracked balance for a routine statement to update
- Any category other than Health/Identity/Immigration/Legal/Finance

If a file was just handed to you in batch mode by `file-archive-audit`'s drift check rather than a fresh filing, the same procedure applies — treat it as "sync this now" rather than "file this now" (Steps 1–6 may already be done).

### Sync protocol — Step A: check whether a note exists for this person/category

Look in `Living Reference/Health/`, `Living Reference/Identity/`, or `Living Reference/Legal/` for the matching person/category note (`Health_Summary_[Person].md` / `Identity_Summary_[Person].md` / your Legal joint summary note), using the same preferred name your Organization Philosophy uses.

- **Note exists** → continue to Step B.
- **No note exists yet** for this person/category → ask the user: "This looks like [health/identity/legal] content for [Person or Joint], who/which doesn't have a Living Reference note yet. Create one from `Living Reference/_Templates/`?" Don't create a new note silently — that's a bigger decision than updating one that already exists, and it's how the vault is meant to extend to a new tracked person as your household changes.

For Legal specifically: default to your joint Legal note even if the triggering document names only one person (a will or POA is still part of the shared estate plan). Only route to a per-person Legal note if the document is unambiguously an individual legal matter unconnected to the joint estate plan (e.g., a personal vehicle title, an individual's separate litigation) — and per any explicitly-out-of-scope Legal subfolders (see the skip list above), most of those won't trigger a sync at all.

### Sync protocol — Step B: extract structured facts

Reuse the content you already read in Step 3 — don't re-OCR. Pull out, in this order:

1. **Document type & date** — what kind of record, and the date it *reflects* (visit date, lab draw date, issue date), not the filing date.
2. **Provider / institution** — English name, with the original-language name in parentheses on first mention so it stays matchable against future scans.
3. **For Health documents:**
   - **Medications** — name (original-language + English/generic name), dose, frequency, supply length, purpose. Always translate the name and purpose, even though the archive's own filenames may keep the original-language term.
   - **Diagnosis / reason for visit**, translated.
   - **Lab results** — only the flagged/abnormal values, with reference range, translated. Don't transcribe a whole normal panel into the note; the note is for signal, the linked PDF is the full record.
   - **Gotchas** — any safety-relevant instruction or warning in the document: drug interactions, "do not chew," "avoid caffeine," "may cause drowsiness — use caution driving," contraindications, allergy notes. Give each its own bullet — don't bury it inside a medication line where it's easy to skim past.
   - **Todos** — anything the document explicitly tells the patient to do next: "repeat in 6 months," "confirmatory test by [date]," "consult a specialist if symptomatic," "follow up if X persists." Each becomes one dated action item, not a paraphrase.
4. **For Identity documents:**
   - Document number (raw — mask it in Step C, not here), issue date, expiry date, status/class/restriction codes (e.g., "corrective lenses required," a visa status code).
   - **Gotchas** — restrictions or dependencies tied to the document (a license restriction, a status that depends on another document staying valid).
   - **Todos** — renewal lead time, e.g., "start renewal ~3–6 months before expiry."
5. **For Legal documents** (trust, wills, POAs, healthcare directives, and amendments/restatements to any of these):
   - **Fiduciary changes** — anyone newly named or removed as trustee, successor trustee, executor, agent (financial/healthcare POA), or guardian, and their position in the priority order. This is the single most important thing to catch — an outdated fiduciary chain (someone who's died, is estranged, or can no longer serve) is a real failure mode, not a hypothetical.
   - **Execution / restatement date** — when the document was signed, and whether it's a first execution, an amendment, or a full restatement superseding a prior version. If it supersedes an earlier document already in the note's "Documents on File" table, that older one moves to History, not just gets overwritten.
   - **Asset transfers / retitling** — anything that changes what's actually funded into the trust (a deed transferring property in, an account retitled into trust name, or conversely a sale/transfer *out* that de-funds something the trust used to hold). This directly feeds the note's Asset Funding Status section — an unfunded or de-funded trust is a structural problem worth surfacing, not just a data point.
   - **Governing law / jurisdiction** — note if a document specifies a governing state/country, especially if it differs from where the family currently lives (relevant to any cross-border-relevance section you keep).
   - **Gotchas** — conditions that change over time and could silently lapse: age-based triggers (e.g., a minor-children provision that becomes moot once the youngest turns a specified age), a POA that's only valid in one jurisdiction, a healthcare directive that isn't recognized outside the state/country it was executed in.
   - **Todos** — anything explicitly calling for future action: a scheduled review date, a funding step that was clearly meant to happen but has no confirming document, a signature or notarization that's missing.

If the source isn't in English, translate everything above. Keep original-language terms in parentheses where they help match future scans — drug brand names, clinic names, diagnosis codes, legal terms.

### Sync protocol — Step C: apply masking rules (Identity and Legal documents)

Never write a full ID number into the note — mask it the same way the existing notes and the source documents themselves already do:

- National ID / resident-registration-style numbers: show whatever prefix portion is non-sensitive by convention in your jurisdiction (e.g. a birth-date-derived prefix), star the rest.
- Passport and driver's license numbers: show only the last 2–4 characters, star the rest.
- Legal documents: mask Social Security numbers and bank/brokerage account numbers the same way (last 2–4 characters only) if one appears in a Schedule of Assets or similar. Trust names, document titles, and fiduciary names are not sensitive in the same way — don't mask those.
- Exception (if your jurisdiction has one, applies wherever it comes up): a designated non-sensitive ID proxy (e.g. a customs/tax-filing code designed as a non-sensitive stand-in for a national ID) and travel/loyalty program numbers are not masked — full values, since these are designed to be shared and aren't themselves government IDs.
- If unsure whether a number counts as sensitive, mask it — the full version lives in the linked scan, which stays under your cloud storage's own access controls.

### Sync protocol — Step D: draft and apply the update, surgically

Living Reference is a directly connected folder — edit the note in place with your normal file tools (read its current content, apply the change, write it back), rather than regenerating the whole file. It's a Google-Drive-backed, synced folder, so Drive's own version history is the safety net for any edit — there's no separate "download a copy, ask the user to manually re-upload it" step needed; edit it the same way you'd edit any other file in a connected folder.

**Section order is fixed: Things To Watch comes first, right after the intro line**, except for any documented exception in your own vault (a note that intentionally leads with a strategy section, or a note under a fixed dashboard format — see [[File_Archive_Auditor_Mandate]]'s internal-consistency check #4). It's the current todo list, not historical reference, so it shouldn't be buried under Current Medications/Currently Valid Documents. Don't reorder sections back to an old med-first/labs-first layout even if that's what an older version of the note looked like.

- **Things To Watch**: add new todos from Step B. This section is a todo list, not an append-only log — keep it to items that are still actually open.
  - **Never silently remove an existing item just because a new document was filed.** If the new document looks like it resolves an open item (e.g., an overdue follow-up test finally happened), mark it `possibly resolved by [new doc, date] — confirm` rather than deleting it outright in the same edit. Only remove it once the user confirms. A wrongly-cleared health flag is a worse failure mode than a stale one.
  - **Once an item is actually confirmed resolved** (user confirmation, or the new document unambiguously closes it out — e.g., a "no significant findings" result, an expired document being renewed), move it out of Things To Watch entirely: fold it into **History** as a compact line (Health notes) or **Superseded / Historical** (Identity notes), and note the resolution in the Update Log. Don't leave a permanent "resolved — confirm" tag sitting in the todo list after it's actually been confirmed — that defeats the point of the section being a current-state list.
  - A purely informational/reassuring result (e.g., a favorable risk score, a negative screening) that isn't an open action item doesn't belong in Things To Watch even on first entry — put it directly in History instead.
- **Current Medications/Regimen** or **Currently Valid Documents**: if this document supersedes something already listed, move the old entry to **Superseded / Historical** (Identity notes) or fold it into **History** as a one-line entry (Health notes) — don't just delete it.
- **Latest Labs**: replace with the new panel's flagged values; compress the previous "latest" panel down to a one-line History entry instead of keeping two full tables side by side.
- **Documents on File** (Legal notes): add or update the row for this document (person, executed date, governing law, source link). If it supersedes an existing row, move the superseded row's summary into History rather than deleting it outright.
- **Key Provisions** (Legal notes): update fiduciary chains, beneficiary terms, or age-based triggers per the facts pulled in Step B. If a change conflicts with what's currently written (e.g., a different successor trustee order), flag it — don't silently overwrite a structural fact without being sure this document is the controlling/most recent version.
- **Asset Funding Status** (Legal notes): update based on any transfer-in/transfer-out found in Step B. An asset moving out of the trust without a replacement is exactly the kind of thing that belongs in Things To Watch, not just a quiet table edit.
- **History**: append one compact line for the new document.
- **Sources**: add the new file's link — see "Getting real Drive links" below.
- **Update Log**: append `- [today's date]: [one-line summary of what changed]`.
- Update the `last_updated` field in the frontmatter.

### Sync protocol — Step E: report what changed

Tell the user, in a short block, what changed: new current-state facts, any new Things To Watch items, anything flagged `possibly resolved — confirm`, and anything moved out of Things To Watch into History because it was confirmed resolved.

### When to ask instead of auto-applying (Health/Identity/Legal sync)

- Extraction confidence is low (garbled OCR on a number, or genuinely unclear whether this is a new prescription vs. a refill of the same one).
- The update would resolve/remove an existing Things To Watch item (see Step D — flag, don't delete, without confirmation).
- No note exists yet for this person/category (see Step A).
- The document contradicts something already in the note in a way that isn't a simple supersession — e.g., a different diagnosis than what's currently on file.

Otherwise, auto-apply and report. The entire point of wiring this into the filing step is that the note stays current without becoming a second manual chore on top of archiving.

### Getting real Drive links for the Sources/scan links you add

A Google Drive connector is available in this environment (tools like `search_files` / `get_file_metadata` on the Drive MCP server) — use it to look up the real `https://drive.google.com/file/d/.../view` link for any File Archive file you just created, moved, or merged, rather than writing a local File Archive path styled as a markdown link. Search by the new filename shortly after filing.

- **If the file has already synced to Drive** (search returns it), use the real `viewUrl`/file ID. This is the common case — sync is usually fast.
- **If it hasn't synced yet** (search returns nothing), don't fake a link. Write the source as plain text with an explicit flag, e.g. `Source: 20260812_Global_Entry_TTP_Dashboard.pdf (⚠ pending Drive sync — not yet linkable)`, and mention it in what you report back. This makes the gap greppable later instead of silently leaving a broken-looking local path in a note meant to hold clickable links.
- The frequent `file-archive-audit` run and the monthly `*-review` tasks each do a pass for the `⚠ pending Drive sync` marker across Living Reference and resolve it via the same Drive connector lookup once the file has caught up.
- **A file's Drive ID can also change out from under an existing link** — e.g. a file that gets renamed/moved/recreated as part of an error-and-revert ends up as a *new* Drive file with a *new* ID, even though the filename is unchanged. A link that used to resolve can go stale this way without ever showing a `⚠ pending Drive sync` marker. When you touch a file that's had this kind of history, re-verify its current linked ID against a fresh `search_files` lookup rather than assuming an existing link is still good.

## Step 7b: Update the lab-trends note (lab-bearing Health documents only)

If the document being synced in Step 7 contains **discrete lab/blood test results** — a checkup panel, standalone lab report, hormone panel, etc. — also update `Living Reference/Health/_Reference/Bloodwork_Trends_[Person].md` (or your own equivalent trends note), in addition to (not instead of) updating the person's `Health_Summary_[Person].md` per the sync protocol above. A prescription, bill, or visit note with no actual lab numbers doesn't trigger this step even if it's otherwise a Health document.

- **Note doesn't exist yet for this person** → create it, following a consistent structure across all tracked people: frontmatter (`tags: [health, reference, labs]`, `scope: [Person] only`, `last_updated`), a wide table per body system (Metabolic/Lipids, CBC, Liver/Kidney, Hormones, etc. — split into multiple tables once one person has enough draws that a single table gets unwieldy), one column per draw date, standardized test names with the raw/original label noted in parens the first time it differs, (H)/(L) flags matching the source's own reference range, a "things worth raising with a doctor" section, a Sources table mapping dates to filenames, and an Update Log. Don't ask before creating this one — it's a data table, not the kind of structural decision Step A in the sync protocol gates (that step is about the main person/category note).
- **Note exists** → add a new column for this draw date to the relevant table(s). **Standardize against what's already in the table** — check existing row labels before adding a new one; the same test shows up under different names across labs and languages. If a raw label doesn't clearly match an existing row, add it as a new row rather than guessing it's the same test, and note the ambiguity in the Update Log so it can be reconciled later rather than silently guessed.
- Record fasting/non-fasting status only if the source document states it — leave blank rather than assuming.
- If a newly-added value is flagged abnormal by the source and represents a new or worsening trend (not a one-off already explained elsewhere in the note), add or update a line in "things worth raising with a doctor" — plain language, pointing at a concrete question to ask, matching the tone already established in the existing notes rather than just restating "this is high."
- Update the note's `last_updated` frontmatter and Update Log the same as any other Living Reference edit.
- Cross-check big/surprising values against the source before writing them in — a misread digit (e.g., 8.4 transcribed as 4.8) or a value pulled from the wrong specimen in a multi-report bundled PDF are both real failure modes in this kind of extraction. If a PDF bundles more than one draw date or specimen ID in the same file, double-check which page belongs to which date/specimen before attributing a value — don't assume page order matches chronological order.
- Link the trends note from `Health_Summary_[Person].md` if it isn't already linked (near the top of the note and from the Sources section) — don't leave a newly-created trends note orphaned with no pointer from the main note.

## Step 7c: Sync Finance documents to your Finance summary note

Extraction and update rubric for Finance documents. Follow the same general discipline as Steps 7/7b: surgical edits to the existing note, never a full regenerate; never silently delete an open Things To Watch item; mask sensitive numbers; keep the Update Log honest about what actually changed.

**Which documents trigger this step:** statements, balance confirmations, passbook/account-opening scans, and balance-export screenshots filed under your Finance Institutions/Net_Worth/Investments subfolders — **plus one explicit exception mirroring Step 7's skip-list carve-out:** a document filed under a Taxes subfolder (e.g. a 1099) that itself confirms or changes an account's ownership or trust-titling status also triggers this step, even though it lives outside Institutions/Net_Worth/Investments. Routine tax filings that don't touch ownership/titling (returns, W-2s, payroll calculations) and routine credit-card statements stay excluded — see the skip list in Step 7 above.

**Step A — check the note exists.** Your Finance joint summary note should already exist (per `_Templates/Finance_Summary_Template.md`). If it's somehow missing, ask before creating — same rule as Health/Identity/Legal.

**Step B — extract:**
1. **Document type & date** — statement period end date, screenshot date, or issue date (not the filing date).
2. **Institution** — standard name per the Organization Philosophy.
3. **Account identification** — last 4 digits, account type (checking/savings/brokerage/IRA/etc.), and owner (Trust/Joint, or the specific tracked person) — cross-check owner against what's already in the note rather than guessing from the folder alone; account ownership can go wrong in an archive (e.g., a credit card mislabeled to the wrong household member for months before a document caught it).
4. **Balance** — the figure as of the document's date. This is the main thing that changes routinely; update the account's row directly.
5. **Structural facts, if present** — trust-titling confirmation/contradiction, a new account not currently in any table, an account closing or zeroing out, a credit card's actual owner.

**Step C — mask.** Never write a full account number — show only the last 4 digits, matching what's already in the note's tables. Mask SSNs the same way if one appears in a document. Institution names, account nicknames, and balances are not sensitive in the same way — don't mask those.

**Step D — apply the update, surgically:**
- **Routine balance refresh** (an account already listed gets a newer balance from a newer statement): update that row's Balance and Source columns, update `last_updated`, and add **one line** to the Update Log — don't narrate the whole reasoning the way a structural change warrants. This is meant to stay cheap and frequent, not become a second manual chore.
- **New account discovered**: add it, but also add a Things To Watch line flagging it as newly found and asking the user to confirm the owner/purpose — unless the document itself makes ownership unambiguous (e.g., a welcome letter addressed by name).
- **Account closing / zeroing out**: move it to the Legacy/To Be Closed or Closed/Zeroed section (matching the note's existing pattern) rather than deleting the row.
- **Ownership or trust-titling conflict** with what's already written: flag it in Things To Watch rather than silently overwriting — same rule as Legal's Key Provisions step.
- **Credit cards**: update ownership if a document clarifies it; don't bother syncing routine balances (see skip list in Step 7) since they're tracked for reference, not net worth.
- **History**: append one compact line for the new document, same pattern as Health/Legal.
- **Sources**: add the new file's link — see "Getting real Drive links" above; the same "use the connector, flag `⚠ pending Drive sync` if it hasn't synced yet" rule applies here too.
- **Update Log**: append `- [today's date]: [one-line summary]` — keep routine refreshes to one line; structural changes can run longer, matching how the note's existing Update Log already varies by significance.
- Update the `last_updated` frontmatter field.

**Step E — deliver.** Same mechanics as Health/Identity/Legal — edit the connected Living Reference file directly (see Step D above); Drive's own version history covers rollback.

## Update Log

*(Fresh install — nothing logged yet.)*
