# Setup Guide

Follow these steps in order. Steps 1–4 are one-time setup; step 5 hands things off to Claude via `BOOTSTRAP_PROMPT.md` for the parts that are easier to do conversationally than by hand.

## 1. Get the templates into your Google Drive folders

**Option A — run the setup script (recommended).** From a clone of this repo:

```bash
# macOS / Linux / WSL
./setup.sh

# Windows PowerShell
./setup.ps1
```

It'll ask for two target locations — typically sibling folders inside your Google Drive (or whatever cloud storage you use; the system assumes Drive-style shareable links, but the mechanics adapt to anything with a stable per-file URL) — and copies the templates there:

- **File Archive** — where your actual documents live.
- **Living Reference** — where the Obsidian vault lives.

It also builds `file-renamer.skill` and `file-archive-audit.skill` into a `dist/` folder from the source in `skills/`, ready to install (see step 5).

**Option B — do it by hand.** Create the two sibling folders yourself (same parent, not nested inside each other — Living Reference links out to File Archive documents, and File Archive should stay a plain document store without notes mixed in), then copy this repo's `File_Archive_Template/` contents into your new File Archive folder and `Living_Reference_Template/` contents into your new Living Reference folder. `File_Archive_Template/` already includes the full starting category-folder skeleton (Health, Identity, Legal, Finance, Family, Home, Immigration, Individual, Insurance, Personal, Security, Work, plus `Unsorted/` and `Trash/`), each with a short `00_About_This_Folder.md` note — delete those placeholder notes once real documents make them redundant, or just leave them. To build the installable skills by hand, zip the *contents* of `skills/file-renamer/` into `file-renamer.skill` and `skills/file-archive-audit/` into `file-archive-audit.skill` (the SKILL.md must sit at the root of each zip, not nested in a subfolder).

## 2. Adapt Organization_Philosophy.md to your household

Before you file a single real document, open `Organization_Philosophy.md` (now sitting in your File Archive folder) and read it in full. It ships with a generic starting taxonomy and placeholder examples. Decide:

- Who's in your household, and what everyday name you'll use for each person consistently in filenames.
- Whether you need all 12 starting categories, want to rename any, or want to add your own.
- Any household-specific override rules (e.g. how you want children's or parents' documents organized).
- Your own recurring institutions, acronyms, and any naming exceptions you'll need — you'll add to these tables as you go, not all at once.

Log every rule you establish from here forward in that file's own Change Log section, per its own instructions — this keeps the rulebook self-documenting instead of relying on your memory (or Claude's) of a decision made months ago.

The category folders, `Unsorted/` (your inbox — new downloads/scans land here before filing), and `Trash/` (files pending your review before permanent deletion — see the Organization Philosophy's "Trash / Pending Deletion" section) all came with the template copy in step 1. You don't need to pre-create any subfolders beyond that — `file-renamer` creates those as needed once you start filing.

## 3. Open the vault in Obsidian

1. Install [Obsidian](https://obsidian.md) if you don't have it, and install the Google Drive desktop app (or your cloud provider's desktop sync client) so your Living Reference folder is mirrored to a real local path on your computer.
2. In Obsidian, choose "Open folder as vault" and point it at your local, synced Living Reference folder.
3. In Settings → Files & Links, turn on "Use [[Wikilinks]]" — this vault relies on `[[Note_Name]]` links between notes throughout.
4. Read `00_README_Living_Reference_System.md` in full — it explains every convention (the dashboard/reference split, the masking rules, how to flag a question for Claude inline, how the reviews communicate with each other) before you start editing.
5. Skim `Archive_Index.md` and the `_Templates/` folder so you know what a filled-in note is supposed to look like once you start adding real content — see `_Templates/00_Templates_Index.md` for which template to copy for what.

You don't strictly need Obsidian to use this system — any Google-Drive-connected AI session can read and write these Markdown files directly. Obsidian just makes the `[[wikilinks]]`, callout blocks, and note graph pleasant for a human to browse. If you skip it, the notes remain plain Markdown and everything else in this guide still applies.

**If you're on Google Drive, install the [Google Drive Markdown Preview](https://chromewebstore.google.com/detail/google-drive-markdown-pre/mcggigjpaggcpngfcgcdconaijliicda) Chrome extension.** Drive's own preview shows a `.md` file as unformatted plain text — headings, tables, and callouts all collapse into raw syntax. This extension renders the file properly in the desktop browser preview instead, which matters here specifically because you'll often want to glance at a dashboard from Drive's web UI without opening the local Obsidian vault. It's a convenience for reading, not a requirement — Obsidian remains the primary way to edit.

## 4. Give Claude access

However you're running Claude (a desktop app with connected folders, a web session with a Drive connector, or similar), connect it to both your File Archive and Living Reference folders. `AGENTS.md` and `CLAUDE.md` at the root of the Living Reference vault are one-line pointers that tell any AI agent to read `00_README_Living_Reference_System.md` first — make sure whatever tool you're using actually loads project-level instruction files like these, or paste the README's contents into your first session manually.

## 5. Install the bundled skills

This kit includes two skills, with source in `skills/file-renamer/` and `skills/file-archive-audit/`:

- **`file-renamer`** — reads a file's content, figures out the correct name/location per your Organization Philosophy, and (for Health/Identity/Legal/Finance documents) syncs the relevant Living Reference note.
- **`file-archive-audit`** — a librarian pass: naming/placement/duplicate checks across the archive, freshness checks against Living Reference, and resolving the inline question/comment/answer callouts described in the README.

If you ran the setup script in step 1, the installable `.skill` packages are already built in `dist/`. Install both through whatever mechanism your Claude environment uses for installable skills (e.g. Cowork's "Save skill" button on an uploaded `.skill` file, or your platform's equivalent). Each one is a short bootstrap that points to the full procedure living in `Living_Reference_Template/_Skills/` or `_Reviewers/` — so once installed, the actual behavior stays editable directly in your vault, in Obsidian, without needing to repackage the skill.

## 6. Set up the scheduled reviews

The four domain-advisor mandates (`Financial_Reviewer_Mandate.md`, `Legal_Reviewer_Mandate.md`, `Identity_Reviewer_Mandate.md`, `Health_Reviewer_Mandate.md`) and the editor pass (`Docs_Quality_Reviewer_Mandate.md`) live in `_Reviewers/` but aren't installable skills — they're meant to run as scheduled tasks that simply point Claude at the relevant mandate file. `BOOTSTRAP_PROMPT.md` walks through creating these with your platform's scheduling mechanism (see the README's "Scheduled reviews" section for the recommended cadence: `file-archive-audit` a few times a week, each domain review monthly on a different day so they don't collide).

## 7. Start filing real documents — incrementally, not all at once

**Build this up in small batches, not in one giant pass.** If you have an existing folder of hundreds of documents sitting somewhere, dumping all of them into `Unsorted/` and asking Claude to process the whole thing in one session will burn through a large chunk of your usage on a single run, and a single very-long session is also where mistakes are more likely to slip through unnoticed. Instead:

1. Drop a manageable batch into `Unsorted/` — a few dozen files, not hundreds.
2. Invoke `file-renamer` on that batch ("sort what's in Unsorted/").
3. Let it run, review what it did, then drop the next batch whenever you're ready.

There's no deadline to get the whole archive filed — the system is designed to accumulate correctly over weeks or months of normal use, not to be bulk-loaded on day one. As Health, Identity, Legal, and Finance documents get filed, the corresponding Living Reference notes fill in automatically per the sync steps in `_Skills/File_Renamer_Mandate.md`, batch by batch, right along with the filing.

If you really do want to bootstrap one domain's dashboard quickly from an existing folder (say, Health), scope it down explicitly rather than pointing at everything at once — e.g. "read everything in my Health/[Person]/Checkups/ folder (about a dozen files) and build the Health_Summary note from the template" — and check the folder's size first. A dozen files is a reasonable single-session ask; a hundred is not.

## Ongoing maintenance

You shouldn't need to touch this system's own instruction files often. When you do want to change how something works — a reviewer's persona, a sync rule, the naming conventions — edit the relevant `.md` file directly in Obsidian. Everything is designed to be human-editable in place, not regenerated from a template each time.

This repo (the templates) and your actual File Archive/Living Reference folders are separate after step 1 — updating this repo later (e.g. `git pull` if you cloned it, or grabbing a newer release) doesn't touch your live folders. If a future version of a mandate or template fixes something you'd want, copy the specific change over by hand.
