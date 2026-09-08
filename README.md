# Living Reference Starter Kit

A system for turning a personal document archive (Google Drive, or any cloud-synced folder) into something an AI assistant can actually reason over and keep current — not just search. It pairs a well-organized **File Archive** (your source documents) with a lightweight **Living Reference** vault (Obsidian notes that stay current-state, not historical) and a handful of scheduled Claude tasks that keep the two in sync.

This is a sanitized, generic extraction of a working personal implementation — every household-specific name, institution, number, and legal/medical detail has been stripped out and replaced with placeholders. What's left is the actual mechanism: the folder conventions, the note formats, and the full instructions for the assistant behaviors that keep it all current. **You're meant to adapt it, not use it as-is.**

## Quick start

```bash
git clone https://github.com/<your-fork-or-this-repo>/DriveOrganizerStarterKit.git
cd DriveOrganizerStarterKit

# macOS / Linux / WSL
./setup.sh

# Windows PowerShell
./setup.ps1
```

The script asks where you want your **File Archive** and **Living Reference** folders created (typically inside your Google Drive, or wherever your AI assistant has folder access), copies the templates there, and builds the two installable `.skill` packages. Then open `SETUP_GUIDE.md` and follow it from step 2 onward.

Don't want to run a script? Everything it does is manual and documented in `SETUP_GUIDE.md` starting from step 1 — copy the two `*_Template/` folders yourself and zip the `skills/*/` folders if you want the installable packages.

## What's in this repo

```
File_Archive_Template/
  Organization_Philosophy.md       — the rulebook for naming, dating, and placing documents
  Health/, Identity/, Legal/, ...  — the starting category-folder skeleton, each with a
                                      short 00_About_This_Folder.md explaining what goes there
  Unsorted/, Trash/                — inbox and pending-deletion folders

Living_Reference_Template/
  00_README_Living_Reference_System.md   — how the whole system works and why
  Archive_Index.md                       — category-level map of the archive
  AGENTS.md, CLAUDE.md                   — pointers so any AI agent reads the README first
  _Reviewers/                            — full mandates for the scheduled review tasks
  _Skills/                               — full mandates for on-request skills
  _Templates/                            — blank note templates for each domain, plus an index

skills/
  file-renamer/            — source for the installable skill: files and renames documents
  file-archive-audit/      — source for the installable skill: audits the archive + vault

setup.sh, setup.ps1        — one-command setup: creates your folders, copies the templates,
                              builds the two .skill packages
SETUP_GUIDE.md             — step-by-step setup (Drive, Obsidian, skills, scheduled tasks)
BOOTSTRAP_PROMPT.md        — a prompt to hand Claude to do most of the setup for you
```

## The core idea

Three layers, each with one job:

1. **File Archive** — your actual documents (PDFs, scans, statements), organized into a consistent folder taxonomy with consistent filenames. `Organization_Philosophy.md` is the single source of truth for the rules.
2. **Living Reference** — a small set of Obsidian notes, one dashboard per life domain (Health, Finance, Legal, Identity, whatever you add), each readable in a couple of minutes: current state, active strategy, things to watch. Deep analysis and history live in linked `_Reference/` subnotes, not in the dashboard itself.
3. **Scheduled reviews** — Claude tasks that keep both layers honest: a frequent librarian pass (files new documents, fixes naming/placement issues, keeps the dashboards synced to what's actually in the archive) and monthly domain-advisor passes (a financial, legal, identity, and health "professional" that re-reads its domain and gives you real strategic input, plus an editor pass that keeps every note well-written).

Read `Living_Reference_Template/00_README_Living_Reference_System.md` for the full architecture, the conventions (masking rules, section order, how to flag questions for Claude inline, how reviews flag things for each other), and the reasoning behind each design choice.

## Where to start

1. Run `setup.sh` / `setup.ps1` (or follow `SETUP_GUIDE.md` from step 1 to do it by hand) to get your File Archive and Living Reference folders in place.
2. Read `SETUP_GUIDE.md`'s remaining steps — adapting `Organization_Philosophy.md` to your own household, opening the vault in Obsidian, installing the two skills, and setting up the scheduled tasks.
3. Hand Claude the prompt in `BOOTSTRAP_PROMPT.md` — it walks through adapting the taxonomy, creating your first Living Reference notes, and setting up the scheduled tasks.
4. From there, the system is meant to run itself, **built up gradually**: drop a small batch of documents into `Unsorted/`, say "sort this," and let the scheduled reviews keep everything current. See `SETUP_GUIDE.md` step 7 for why this should happen in batches, not as one giant bulk import. Your job becomes reading the dashboards and answering the occasional inline question Claude leaves in a note, not maintaining the system by hand.

## A note on scope

This kit assumes you're comfortable giving an AI assistant real access to your financial, legal, health, and identity documents, and that you understand the tradeoffs of storing that information in a cloud-synced, AI-readable format. Read `00_README_Living_Reference_System.md`'s section on masking and access control before you put anything sensitive in. Nothing here is legal, financial, or medical advice — the whole design is meant to help you have better conversations with the actual professionals in your life, not replace them.

## Contributing

This is a starter kit meant to be forked and adapted, not a project that needs to stay generic forever — most of the value is in adapting `Organization_Philosophy.md` and the review mandates to your own situation. That said, fixes to the mechanism itself (a genuinely broken instruction, a missing edge case in a mandate, a setup-script bug) are welcome as issues or pull requests.

## License

MIT — see `LICENSE`. Use it, fork it, adapt it, share it.
