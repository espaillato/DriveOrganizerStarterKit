---
tags: [system, meta]
last_updated: 2026-01-01
---

# Living Reference System — How This Works

This is a system for turning a File Archive (Google Drive) from a pure repository into something actionable. It does **not** replace the archive — every scan stays exactly where it is, under `Organization_Philosophy.md`'s taxonomy. These notes are a thin, current-state layer on top: "what do I need to know right now," with links back to the source documents for the full record. **Each summary note is a dashboard for its section (Health, Financial, Legal, Identity, or whatever domains you add) — current state, strategy, and actionable items, with things to watch. In-depth analysis, details, explanations, and historical context live in that category's `_Reference/` subfolder instead, cross-linked both directions.**

## Contents

- [[#The architecture: data → insight]]
- [[#What's in this system]]
- [[#Keeping notes lean: snapshot, not encyclopedia]]
- [[#Information density: dashboards are point-in-time, not logs]]
- [[#The reviews are advisors: strategy, not fact-checking]]
- [[#Why plain Drive links, not embeds]]
- [[#Flagging questions, comments, and answers for Claude]]
- [[#The reverse direction: Claude asking you]]
- [[#Flagging between reviews (agent-to-agent)]]
- [[#Section order]]
- [[#Why some numbers are masked or omitted]]
- [[#The part that actually matters: keeping this current]]
- [[#Scheduled reviews]]
- [[#Verify before you rely on this]]
- [[#Update Log]]

## The architecture: data → insight

Three layers, each with a distinct job:

1. **File Archive (Google Drive)** — where source documents live, organized per `Organization_Philosophy.md`. `file-renamer` files and names things; `file-archive-audit` (scheduled) keeps the archive organized and syncs **raw data** into Living Reference (balances, lab values, expiry dates, freshness/link/consistency checks). These are the librarians.
2. **Living Reference** — two sublayers per domain: the **summary note is the dashboard** (current state, strategy, open actions, Things To Watch — readable in minutes), and **`_Reference/` holds the what and the why** (analysis, derivations, glossaries), cross-linked both directions. History lives in Update Logs, never as narration in the body — and Update Logs themselves get capped/archived per the density conventions below, so they don't grow forever.
3. **Scheduled reviews** — two kinds, both periodic. The **domain advisors** (each `*-review`) read their domain the way the relevant professional would (CFA/tax planner, attorney, physician, or whoever fits your domains — see "The reviews are advisors" below) and turn data into insights, strategic initiatives, and actionables. **`docs-quality-review`** is not an advisor — it's the vault's editor, a single vault-wide pass that keeps every note well-written and well-structured (verbosity, historical clutter, consistency, link currency, tables of contents on long notes) regardless of domain. Neither kind is a semantic/freshness pass — that's layer 1's job.

**Why this matters:** the point of building this is to make an assistant genuinely useful for the decisions that matter most — health, money, legal protection, anything with real defensive value. Think deeply about each actionable and strategy, especially defensive ones. You are (or should become) an active participant who verifies important findings with the appropriate professional, not someone who follows an AI's advice blindly — **so don't let the system cage its own answers**; have it act as the professional and let you decide on execution. The job of each review is to give you the full, specific picture so you can make informed decisions, and when professionals get involved, to help you walk into that conversation prepared: people routinely omit details that matter to a professional and get generic or bad advice because they didn't know what was important to mention. An assistant with the full cross-domain picture is the first line of defense against that.

## What's in this system

This section is a map, not a fixed list — add a `<Domain>_Summary_[Person or Joint].md` and matching `_Reference/` folder for every domain you actually want tracked, following the pattern below. The starter set:

- `Archive_Index.md` — a category-level map of the whole File Archive: doc counts, date ranges, links to the deeper summary notes below where they exist, and a short hand-picked "quick access" list per category. Deliberately not a full file listing — see its own "What this index doesn't cover" section for the line between this and a real per-category summary note.
- `Health/Health_Summary_[Person].md` (one per tracked person) — current state of health as a personal dashboard, meant to be the starting point before any doctor visit or checkup, or just to gauge where health stands and what to improve. **Use a dense, five-section dashboard format** (current status incl. active meds, what's driving outcomes, concrete actions, what's missing), with no chronological history or visit-by-visit narrative — put that detail in an actively-maintained `Health/_Reference/Health_Detail_[Person].md` note that keeps the fuller format (Things To Watch, visit log, Advisory Notes, History) as the substrate each dashboard is synthesized from.
- `Health/_Reference/Medication_History_[Person].md` — every medication on file for each person (active + discontinued), with names, purpose, protocol, and person-specific dangers. Each dashboard's Active Medications section is sourced from that person's note's "Active" rows only.
- `Identity/Identity_Summary_[Person].md` — currently valid documents with expiry dates, watch list for renewals, superseded documents. A complete picture matters here — a missing document is treated as a real gap, not just a filing gap.
- `Health/_Reference/` — shared background notes (e.g. a procedure or condition glossary) that explain what something actually *is*, plus per-person data notes too large for the main snapshot (e.g. a lab-value-over-time trend note, a wearable/fitness-data trend note). Person notes link here instead of re-explaining or re-listing the same thing twice. Also where detailed analysis of health conditions, treatment options, and improvement programs belongs.
- `Legal/Legal_Summary_Joint.md` (or per-person, if that fits your situation better) — the estate plan (trust, wills, POAs, healthcare directives): what's on file, fiduciary chain, asset funding status, open todos.
- `Finance/Finance_Summary_Joint.md` — the household's financial dashboard: current state, strategy, and actionable items, driven by periodic net-worth/balance data. Every account, cross-referenced against the archive, plus an explicit "needs confirmation" list for accounts that don't map to any documented owner or institution yet. The summary itself stays dashboard-and-actionable only — the actual analysis lives in `_Reference/`. Feeds the Legal note's Asset Funding Status rather than duplicating it.
- `Legal/_Reference/`, `Finance/_Reference/` — same snapshot-vs-encyclopedia split as `Health/_Reference/` (see below), for whenever a definitional note (e.g., what a specific trust structure is, what an account type is) is worth pulling out of the joint note rather than explained inline. Created on first use by the relevant domain review, or manually, following the same rule as `Health/_Reference/`.
- `Identity/_Reference/Renewal_Windows_Glossary.md` — per-document-type renewal-eligibility rules, researched via web search with confidence levels noted per type. The Identity summary notes' "Renewal Eligible" column is computed from this note. `file-archive-audit` reads it on schedule to auto-promote a document to a Things To Watch action item the moment its window opens; `identity-review` re-verifies the rules themselves haven't changed.
- `Individual/Goals_[Person].md` — a yearly goals note, updated through the year. Current-year goals, a condensed history, and cross-year insights, with wealth/health goals cross-linked to the Finance and Health notes instead of re-tracked here.
- `_Reviewers/` — the full mandate for every scheduled review (persona, files, procedure, constraints, report format), plus the mechanics they share (`_Shared_Review_Protocol.md`). Start at `_Reviewers/00_Reviewers_Index.md`. See "The reviews are advisors" below for why this exists.
- `_Skills/` — the full mandate for vault-facing skills invoked by request or hand-off rather than on a schedule (`file-renamer`; `file-archive-audit`'s mandate stays in `_Reviewers/` since its scheduled side is primary). Start at `_Skills/00_Skills_Index.md`. Same rationale as `_Reviewers/` — the skill's saved copy is a short bootstrap pointing here, so its actual behavior lives in the vault, not buried in a skill package.
- `_Templates/` — blank versions of each note type, for adding a new person or a new domain later.

## Keeping notes lean: snapshot, not encyclopedia

The whole point of these notes is to be readable in a couple of minutes right before an appointment, meeting, or decision — current state, active items, and the follow-ups/gotchas worth raising with a professional. That's what belongs in a person's main note.

General background that doesn't change per-visit — what a procedure is, how a medication works, why a lab test is or isn't fasting-sensitive, what a trust structure is — does *not* belong there, even though it's genuinely useful. If more than one person in the household sees the same effect (two people going to the same provider, two people holding the same kind of account), that content would otherwise get written out twice and drift out of sync. Instead:

- Put it in a `_Reference/` subnote under the relevant category (`Health/_Reference/`, `Identity/_Reference/`, `Legal/_Reference/`, `Finance/_Reference/`).
- Link to it from each person's note (`[[Note_Name]]`) at the point where it's relevant, rather than inlining the explanation.
- If a `_Reference/` note doesn't exist yet for something worth explaining, create it rather than writing the explanation inline "just this once" — it tends to get copy-pasted into the next note that needs it.

When trimming a person's note to keep it lean, don't touch **Things To Watch** or the specific facts of what happened at a given visit/event (dates, diagnosis codes, which medication/dose, which document) — those are exactly the snapshot content this system exists for. Only definitional/explanatory material moves out.

## Information density: dashboards are point-in-time, not logs

Low information density costs you reading time on every read, and a growing Update Log costs your assistant's context budget on every future read of a note — both are density problems the editorial review (below) should actively manage, on top of the encyclopedia/historical-narration split above.

- **Table cells stay short.** A cell states the current value, target, or status in a sentence or fragment, not a paragraph of reasoning — move real reasoning to a linked `_Reference/` note if it's worth keeping, otherwise cut it.
- **Update Logs are capped, not endless.** Once a note's Update Log passes roughly 10-15 entries, split it: keep the most recent ~5-10 (compacted to one dense line each), move everything older verbatim to a new `<Note>_History.md` in that domain's `_Reference/` folder, and leave a one-line pointer at the top ("Full history before [date]: [[<Note>_History]]"). Nothing is deleted — it's relocated so a normal read doesn't have to load it.
- This is a live area, not a fixed template — iterate on the format (denser tables, bullets, a changed-since line, etc.) as you find what actually works for how you read these notes.
- **`<Note>_History.md` files carry a `last_updated:`, same as every other note** — set to the date of the rollover that created the file or most recently appended to it, so it's clear at a glance how far the history goes and when it was last rolled over.

## The reviews are advisors: strategy, not fact-checking

Extends the snapshot-vs-encyclopedia split above to recommendations, not just definitions: when a note gives a specific recommendation — target allocations, a legal/estate-plan change, something to raise with a doctor — the actionable conclusion (what to do, target numbers) belongs in the main note; the reasoning and supporting analysis belong in `_Reference/`, linked from the actionable line rather than inlined.

**Each domain's periodic review approaches its notes from the standpoint of the relevant professional — organizing the Living Reference into strategic initiatives, turning data into insights and actionables, not just checking facts.** Each review's full mandate — persona, files, exact procedure, constraints, report-back format — lives in its own note under `_Reviewers/` rather than here. Start at `_Reviewers/00_Reviewers_Index.md` for the full picture, including which review owns what and the mechanics they share (`_Shared_Review_Protocol.md` — the async annotation loop, the full-re-analysis standard, the never-re-OCR rule, Goals reconciliation, the "don't cage answers" principle, and the sum-of-parts/best-practice check described below).

**`docs-quality-review` is a different kind of review — an editor, not an advisor.** It runs vault-wide across every domain rather than owning one, and does no subject-matter judgment — see `Docs_Quality_Reviewer_Mandate.md` for its full scope (verbosity, historical-narration relocation, cross-note consistency, link currency on its own edits, Tables of Contents on long notes, and information density — compressing verbose table cells and capping/archiving Update Logs into `_Reference/*_History.md` notes).

**The async annotation loop is how this runs day to day.** You annotate any note with `> [!user-question]` / `[!user-comment]` / `[!user-answer]`-style callouts (see the flagging section below — rename the callout type to match your own name if you want, the mechanics stay the same); the reviews resolve them with advisor-grade depth — cleaning up, researching, and folding the results into the dashboard/reference structure — rather than requiring a live conversation. The assistant's own flags flow the other way, as Things To Watch items and report-backs. Reviews are not just semantic passes over the text; they are the strategy passes. Full mechanics in `_Shared_Review_Protocol.md`.

Before finalizing a recommendation with multiple parts (e.g., several account reallocations at once, several estate-plan changes, several health-related suggestions), each domain review checks two things that individual fact-checking won't catch on its own — **sum-of-parts consistency** (recompute the aggregate effect of the full set of changes against the note's own stated risk framework or goals, not just each change in isolation) and a **best-practice/advisor-grade check** (is this the advice a competent professional would actually give, not just "is each fact accurate") — see `_Shared_Review_Protocol.md`'s "Format contract" section for the full statement of both. This isn't a new task to run on a schedule — it's part of finishing any recommendation before it's presented as ready to act on, in any advisor domain.

## Why plain Drive links, not embeds

Plain `drive.google.com/file/d/...` links (rather than a local Drive-desktop sync inside the vault) mean clicking a source link opens the document in your browser rather than inline in Obsidian — one extra click, but zero extra setup, and it works from any device. If you'd rather embed local file paths because you run a fully-synced local Drive mirror, that's a reasonable alternative — just be consistent and document the choice here.

**Every File Archive reference should be a real Drive link, no exceptions.** A citation like "filed under `Finance/Taxes/...`" or "no Drive link captured — filed directly" is not acceptable in a finished note — look up the file's Drive ID via a Drive connector before leaving a citation in place. This applies to every sync, scheduled review, and manual edit going forward, not just a one-time cleanup.

## Flagging questions, comments, and answers for Claude

**This is the primary async channel between you and your assistant** — rather than saving questions for a live conversation, annotate the document itself and let the next audit/review pass resolve it with full advisor-grade depth. If you have a question, comment, or answer about something in a note, mark it inline with an Obsidian callout using one of three custom types, right next to whatever it's about (a table row, a bullet, a section). The examples below use "user" as a generic placeholder — pick your own name/handle (your first name, an initial, whatever you like) and use it consistently everywhere this convention appears instead:

```
> [!user-question]
> Is the online renewal window actually 90 days, or 60?

> [!user-comment]
> That case really did run 2009–2011, don't re-flag the date.

> [!user-answer]
> Yes, standardize those filenames.
```

- `[!user-question]` — something you want the assistant to look into and answer.
- `[!user-comment]` — an instruction, correction, or piece of context the assistant should act on.
- `[!user-answer]` — your answer to something the assistant already flagged elsewhere (an ask-the-user item, a `⚠` marker, an open Things To Watch question).

A custom type (rather than Obsidian's built-in `[!question]`/`[!note]`) keeps this unambiguous to grep for — nothing else in these notes should ever match your chosen `[!<name>-` prefix.

`file-archive-audit` scans every note in the vault for these at the start of each run as a first-class step, not incidental housekeeping — it resolves every one it finds that same run, **applying a triage rule: mechanical callouts (factual lookups, corrections, filing instructions) are resolved on the spot; strategic callouts (allocation/tax/estate/visa/clinical judgment) are still resolved the same run, at the relevant domain's advisor standard — reading that domain's mandate in `_Reviewers/` (persona, cited research, real numbers, dashboard/reference filing) — and named in the run report as queued for the periodic domain review to re-examine comprehensively.** This gives timely advisor-level answers between reviews, while the reviews remain the layer that validates the advice still holds best practice. Each periodic `*-review` task also checks its own category's notes as a backstop, in case something was added and needs a deeper look than the frequent sweep gives it. Once resolved, the assistant removes the callout and logs what happened in the Update Log — so if a callout disappears without you seeing a reply in the note itself, check the Update Log for what was done with it. If a question genuinely can't be answered confidently, it's left in place rather than silently deleted, and called out in that run's report.

Turnaround is bounded by `file-archive-audit`'s cadence, not instant — a flag added right after a run may sit until the next pass.

## The reverse direction: Claude asking you

The three types above are you → assistant. The traffic runs the other way too: when a run turns up something only you can actually decide — a genuine preference, a missing-data proxy call, disambiguating intent — rather than something research or judgment can settle on its own, it's written inline the same way, addressed to you by name:

```
> [!agent-question]
> For [you]: we don't have resting-heart-rate data — pick one of these as a proxy: min non-sleep HR, avg sleep HR, min sleep HR.
```

- **Format:** `[!agent-question]`, first line always `For <you>: <question, with options if there are natural ones>`.
- **Never self-answered.** No run resolves its own `[!agent-question]` — that defeats the point of asking. It sits until you reply with a `> [!user-answer]` directly beneath it, same as answering any other flagged item; the next run that sweeps `[!user-answer]`s applies it and removes **both** callouts, logging the resolution.
- **Where there's no specific note to attach to, use `Archive_Index.md`'s "Open Filing Questions" section instead of staying report-only.** A pure File Archive ambiguity — which category a raw document belongs in, or an unattended `file-renamer` run hitting its "always ask" rule with no one to ask — now has a home: `Archive_Index.md` (the one vault-wide index every category maps to) carries an "Open Filing Questions" section for exactly this case, same `[!agent-question]`/`[!user-answer]` mechanics as everywhere else. Any skill can write there; see that section's own instructions.
- **Dedup before writing**, same as `[!agent-comment]` — don't re-ask the same open question on three consecutive runs while it waits for you to notice it.
- **Still summarized in that run's report**, same principle as agent-comment — inline is the delivery mechanism, not the only place it's visible.

**A second, reactive case: when your own callout can't be understood.** If a run sweeps a `[!user-question]` / `[!user-comment]` / `[!user-answer]` and genuinely can't make sense of it or act on it (ambiguous reference, contradicts a known fact, unparseable), that's not a fresh question the agent is originating — it's a failed reply to something you already said, so it uses `[!agent-comment]` instead of `[!agent-question]`, replied directly beneath the original callout:

```
> [!user-comment]
> Handle the withdrawal timing the way we discussed.

> [!agent-comment]
> For [you]: we don't have a record of that discussion in this note or its Update Log — can you say what timing you meant, or point to where it was decided?
```

Leave the original callout in place (don't delete an instruction just because it's unclear), reply beneath it, and flag it in the report — this replaces just leaving a vague inline note with nothing to reply to. Same resolution mechanics as everything else here: you clarify (either editing your original callout or replying with `[!user-answer]`), the next sweep applies it and cleans up.

## Flagging between reviews (agent-to-agent)

Distinct from the `[!user-*]` channel above — this is one scheduled run flagging something for a *different* scheduled run to pick up, not for you (a report only reaches you if you read it and relay it forward; a note in the note itself reaches the next run automatically). Any skill that spots something belonging to another skill's territory writes it inline, right at the spot, instead of only mentioning it in that run's report:

```
> [!agent-comment]
> For docs-quality-review: this section has read like a changelog for two review cycles now — worth a verbosity pass.
```

- **Format:** one callout type, `[!agent-comment]`. The first line always starts `For <skill-name>:` — a skill's sweep (part of its own async annotation loop, same as the `[!user-*]` sweep) only picks up comments addressed to it by that exact name, and ignores ones addressed to other skills.
- **Lifecycle:** identical to `[!user-comment]` — the target skill acts on it, then removes the callout and logs what it did in the Update Log. If it can't act on it confidently, it's left in place and named in that run's report, never silently dropped.
- **Dedup before writing.** Check for an existing unaddressed `[!agent-comment]` covering the same issue before adding a new one — e.g. a frequent audit shouldn't stack three duplicate comments about the same thing while it waits for a monthly review's next pass.
- **This replaces "flag it in the report," not the report itself.** Any skill instruction that says "flag X for review Y" means writing an `[!agent-comment]` addressed to Y at the spot — the report should still summarize what was flagged, for your visibility, but the note is the delivery mechanism now, not you.

## Section order

Per the internal-consistency convention, **Things To Watch is the first section after the intro line** in every person note and joint note — unless a note has moved to the fixed five-section dashboard format described above (Health), in which case that fixed order is the convention instead. If one domain's dashboard genuinely needs to lead with something else (a Finance note leading with strategy status, say), that's fine — just document the exception here explicitly, the same way, so an audit pass knows not to flag it as drift.

## Why some numbers are masked or omitted

If this vault syncs (iCloud/Obsidian Sync/git/etc.), the notes live in more than one place — potentially with weaker access control than Drive has. So:

- National-ID-style numbers are masked the same way the issuing institutions themselves mask them: first digits shown, rest starred (or whatever partial-reveal convention your documents already use).
- Passport and driver's license numbers show only the last 2–4 characters.
- Full numbers are never in these notes — only in the linked scans, which stay on Drive under Drive's own access controls.

If you decide your vault's sync target is trustworthy enough to hold full numbers, that's your call to make deliberately — better to loosen this intentionally than have an assistant guess wrong in the other direction.

## The part that actually matters: keeping this current

A note that goes stale is worse than no note, because it looks authoritative. This system only works if updating it is attached to an existing habit, not a new one. The natural hook is your filing workflow: whenever `file-renamer` files something new under `Health/<Person>` or `Identity/<Person>`, that's the trigger to also ask "does this change the current-state summary?" — new prescription → update meds section; new lab panel → update labs + re-flag; new ID scan → update the valid-documents table and move the old one to superseded.

This is wired up: `file-renamer`'s sync step (see `_Skills/File_Renamer_Mandate.md` for Health/Identity/Legal, and its own Finance-specific step) runs this check automatically whenever a Health, Identity, Legal, or Finance document gets filed, and `file-archive-audit` separately flags any note that's drifted behind newer archive files and hands it back to `file-renamer` to sync. Be clear on what "automatic" means here, though — there's typically no tool that can update a cloud-hosted file's content in place from inside an agent session, so each sync still ends with either a direct write to a locally-mirrored vault (if one is connected) or a delivered file you replace manually via your sync tool's version history if it isn't. "Wired up" means the extraction and drafting happen without being asked; getting the result into your synced storage is the one step that may still need a device connection or two clicks, depending on your setup.

**Staying current isn't just "is there newer data" — it's "does a corrected fact actually match everywhere it's stated."** `file-archive-audit`'s internal-consistency pass and each domain review's cross-document step both carry a standing rule: when a fact is corrected anywhere, grep the rest of that domain for every other statement of it and fix them all in the same pass, not just the one that prompted the fix; and before writing or leaving in place a claim that one dated thing caused or explains another, check that the date ranges actually support it rather than assuming proximity in the same note means a real link. Any domain review should adopt the same two rules verbatim — they're general vault-hygiene, not domain-specific.

## Scheduled reviews

Division of labor (see "The architecture" above): `file-archive-audit` organizes the File Archive and keeps Living Reference's **raw data** current; the domain `*-review` tasks are the **advisors** — they re-read their domain end-to-end and do the strategic pass (priorities that should shift, claims that no longer match current science/law/regulation, recommendations that no longer hold up to the advisor-grade standard); `docs-quality-review` is the **editor** — a vault-wide pass keeping every note's prose and structure tight regardless of domain.

A cadence that works well for a household-scale vault:

- `file-archive-audit` — 3x/week (e.g. Monday/Wednesday/Friday). Archive organization, Living Reference freshness/internal consistency across every tracked category, and any daily-cadence date-driven checks (like the Identity renewal-eligibility check).
- One `*-review` per domain, monthly, each on a different weekday-of-month so none collide with each other or with `file-archive-audit`'s cadence (e.g. 1st Tuesday, 2nd Tuesday, 3rd Tuesday, 4th Tuesday for four domain reviews, 4th Thursday for `docs-quality-review` two days after the last domain review so it always runs after that month's findings have landed). If you implement the "Nth weekday of the month" gate yourself, do it as a plain weekly cron trigger plus a day-of-month range check at the very top of the task's own prompt — combining a day-of-month range with a day-of-week in one cron expression is ambiguous across schedulers (AND vs. OR semantics vary by implementation) and risky to get silently wrong. A task firing on a non-matching week should exit in one line without touching any files.
- `identity-review` (or your equivalent) re-verifies renewal-window *rules* — the day-to-day "has a document crossed into its window" check stays `file-archive-audit`'s job, so the two don't overlap.

**Each domain review is a full periodic re-analysis, not an incremental diff, never re-opens or re-OCRs an unchanged source document, and reconciles every tracked person's Goals note against its own domain every run.** These standards are common to every domain review and documented once in `_Shared_Review_Protocol.md` rather than repeated per domain — see that note's "Full monthly re-analysis," "Never re-open or re-OCR," and "Goals reconciliation" sections. `docs-quality-review` is the exception (editorial, not fact-verification, so "re-analysis" doesn't apply the same way — see `Docs_Quality_Reviewer_Mandate.md`).

See the `schedule` skill (or whatever your platform's task-scheduling mechanism is) for how to actually wire each of these up — the `BOOTSTRAP_PROMPT.md` at the root of this starter kit walks through it.

## Verify before you rely on this

Everything in these notes was extracted by reading a subset of your archive, not necessarily the whole thing — see each note's Sources section for exactly which files were used and which visible-but-unread files were skipped. Keep a running note (in this section, or in each domain's own Things To Watch) of anything still genuinely open from your initial build-out pass, so it doesn't quietly get assumed resolved just because it stopped being mentioned.

## Update Log

- 2026-01-01: Starter-kit version created — see the top-level `README.md` and `SETUP_GUIDE.md` for how to adapt this to your own household or use case. This file's own history before this point belongs to the original implementation this kit was extracted from, not to your copy — start your own log here.
