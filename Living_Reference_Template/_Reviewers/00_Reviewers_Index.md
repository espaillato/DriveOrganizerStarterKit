---
tags: [system, meta, reviewers]
last_updated: 2026-01-01
---

# Reviewers — What Each Scheduled Review Does

This folder holds the full mandate for every scheduled review that touches this vault: who each one acts as, what it does each run, and the mechanics shared across them. Whatever your scheduling platform's own task-prompt mechanism is, that prompt should carry only a bootstrap — its dispatch gate and a pointer to its mandate file here — so the substance of every review lives in the vault itself, readable and linkable like any other note.

## Contents

- [[#The reviewers]]
- [[#Shared mechanics]]
- [[#How a scheduled task uses this folder]]

## The reviewers

Six scheduled tasks is the starting set below — add, remove, split, or merge domains to fit your own situation (e.g. you might not need a separate Identity review, or you might want to add one for a business, a rental property portfolio, or anything else with enough ongoing state to warrant strategic tracking). Four of the starting six are domain advisors — each approaches its domain the way the relevant professional would, turning data into strategic insights and actionables, not just checking facts. One is an editor. One is the archive's librarian.

| Reviewer | Acts as | Owns | Cadence |
|---|---|---|---|
| [[File_Archive_Auditor_Mandate]] | Archive & vault librarian — not an advisor | File Archive organization; Living Reference freshness, internal consistency, and the frequent `[!user-*]`/`[!agent-*]` triage sweep | Frequent (e.g. Mon/Wed/Fri) |
| [[Legal_Reviewer_Mandate]] | Estate/legal-risk/immigration attorney (adjust the hat to whatever legal complexity your situation actually has) | Your Legal summary note(s) and `Legal/_Reference/` | Monthly, e.g. 1st Tuesday |
| [[Financial_Reviewer_Mandate]] | CFA and tax planner | Your Finance summary note and `Finance/_Reference/` | Monthly, e.g. 2nd Tuesday |
| [[Identity_Reviewer_Mandate]] | Mostly mechanical, immigration/legal-status lens where relevant | Your Identity summary note(s), a renewal-rules glossary, and `Identity/_Reference/` | Monthly, e.g. 3rd Tuesday |
| [[Health_Reviewer_Mandate]] | Integrative/functional-medicine physician | Every tracked person's Health dashboard, Detail note, Medication History, and any Trends/glossary notes | Monthly, e.g. 4th Tuesday |
| [[Docs_Quality_Reviewer_Mandate]] | Vault editor/technical writer — not an advisor | Every note in the vault, editorially | Monthly, e.g. 4th Thursday |

See `_Skills/00_Skills_Index.md` for `file-renamer` and other skills invoked by request or by hand-off rather than on a schedule.

## Shared mechanics

The async annotation loop, the full-periodic-re-analysis standard, the never-re-OCR-unchanged-files rule, the archive-drift/hand-off-to-file-renamer pattern, Goals reconciliation, the "don't cage answers" principle, the dashboard/`_Reference` format contract, and the report-back shape are common to the four domain advisors and documented once, in [[_Shared_Review_Protocol]], rather than repeated in each mandate file. `docs-quality-review` and `file-archive-audit` are structurally different (an editor and a librarian, not advisors) and are each fully self-contained — see their own mandate files.

## How a scheduled task uses this folder

Each scheduled task's own prompt should carry only its dispatch gate (a day-of-month check for the monthly tasks; none needed for a task that runs on a plain fixed weekly cadence) and a pointer to read its mandate file here. Everything about what the review actually does — role, files, procedure, constraints, report format — lives in the mandate file.

`file-archive-audit` also reads the relevant domain mandate file's "Role and mandate" section directly whenever it needs to resolve a strategic `[!user-*]` callout at full professional depth during its frequent sweep — see [[File_Archive_Auditor_Mandate]]'s Triage rule.

## Update Log

*(Fresh install — nothing logged yet.)*
