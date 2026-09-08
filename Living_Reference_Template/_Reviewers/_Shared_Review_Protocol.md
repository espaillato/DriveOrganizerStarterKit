---
tags: [system, meta, reviewers]
last_updated: 2026-01-01
---

# Shared Review Protocol

This note holds the mechanics common to every domain review (`legal-review`, `financial-review`, `identity-review`, `health-review`) — the parts that would otherwise get duplicated near-verbatim across each one's own mandate. Each domain's own mandate file (`Legal_Reviewer_Mandate.md`, `Financial_Reviewer_Mandate.md`, `Identity_Reviewer_Mandate.md`, `Health_Reviewer_Mandate.md`) states its persona, files, domain-specific procedure, and constraints, then points back here for everything below. **`Docs_Quality_Reviewer_Mandate.md` is structurally different — it's an editor, not an advisor — and opts out of most of this note; see its own file for exactly which parts still apply to it (the Table of Contents / report-back shape only).**

See `[[00_Reviewers_Index]]` for what this folder is and why it exists, and `[[00_README_Living_Reference_System]]` for the wider vault architecture this fits into.

## Contents

- [[#Full periodic re-analysis, not an incremental diff]]
- [[#Never re-open or re-OCR an unchanged source document]]
- [[#Archive drift: read it yourself, or hand off to file-renamer]]
- [[#The async annotation loop]]
- [[#Resolve pending Drive sync markers]]
- [[#Goals reconciliation]]
- [[#Don't cage answers]]
- [[#Format contract]]
- [[#Report-back shape]]

## Full periodic re-analysis, not an incremental diff

Living Reference is what you base decisions on, so it has to reflect the best current information every review cycle, not just get patched around whatever new document happened to arrive. Every run re-reads and re-verifies **every existing claim, recommendation, and rule/law/science reference already in your domain's notes** — regardless of whether anything changed since last run. A new document (see "Archive drift" below) is one input to the run, not the trigger for how much gets scrutinized. Most cycles this just reconfirms the note is still accurate; the point is that the check happened, not that something was found. This is why these reviews work best on a monthly (not weekly) cadence — full re-verification is the expensive option, deliberately traded against a cadence that keeps it affordable.

When a re-verification turns up something that changed, propagate the fix everywhere that fact appears — not just the note that prompted it, and not just within your own domain if the fact also appears in another domain's notes (leave an `[!agent-comment]` for that domain's review rather than editing its notes yourself).

For a review this size, don't do the full re-verification serially in one context — spin off a subagent per major area (see your mandate file's own guidance on how to split it), track progress with a task list, and consolidate into one report. **When delegating to a subagent, copy this protocol's relevant rules and your mandate file's format contract into the subagent's own prompt verbatim — don't paraphrase them away.** A requirement that isn't explicitly restated in a subagent's instructions reliably gets dropped, no matter how clearly it's stated here.

## Never re-open or re-OCR an unchanged source document

That would be pure waste. Only a genuinely new or changed file gets read (the archive-drift check below). "Full re-analysis" above is about re-checking whether a fact *already recorded* in Living Reference still means what it used to, against current external standards — for example, a lab result that was flagged normal under an old reference range might now read as a high-risk factor under an updated one, or a change in one value changes the implications of another test in relation to it. Catching that is the point — comparing an already-extracted value against current guidance and correcting the note's interpretation in place, not re-extracting the number from the source document. This holds even during the full-domain re-verification pass: files not flagged as newer by the archive-drift check are never re-opened or re-OCR'd just because this is the comprehensive periodic pass.

## Archive drift: read it yourself, or hand off to file-renamer

Compare your domain's in-scope File Archive folders' newest file mtime against your notes' own `last_updated` frontmatter — that's your bookmark for what's new since your last run (your mandate file names the exact folders).

- **When a newer document adds real interpretive value from your domain's professional lens**, read it yourself. OCR if needed: same `pdftotext` → `pdfimages`+`tesseract` → visual-inspection fallback `file-renamer` uses. Sync the note directly, following the same field rubric as `file-renamer`'s own sync step for your domain (your mandate file names the exact step), bringing your domain's professional judgment to the interpretation rather than mechanical extraction.
- **Hand off to `file-renamer`** — invoking it directly in this same run, not just noting it in the report — only when the file itself needs renaming/refiling (sitting in `Unsorted/`, a generic scanner name, wrong category). That's a filing problem, not a reading problem, and stays `file-renamer`'s job.
- Files not flagged as newer here are never re-opened or re-OCR'd this run, no matter how thorough the rest of the pass is — see "Never re-open or re-OCR" above.

## The async annotation loop

This is a primary purpose of every review run, not incidental housekeeping. You communicate by annotating notes directly with Obsidian callout blocks (full convention in `[[00_README_Living_Reference_System]]`):

```
> [!user-question]
> Is the online renewal window actually 90 days, or 60?

> [!user-comment]
> That case really did run 2009–2011, don't re-flag the date.

> [!user-answer]
> Yes, standardize those filenames.
```

Sweep every note in your Files list for these. Resolve each with your domain's full professional-grade depth: research via web search (not training-data recall) for anything rule/law/science/market-dependent, with sources and dates cited; analyze against this specific household's facts; fold results into the dashboard/reference structure; remove the callout; log it in the Update Log. `file-archive-audit` also sweeps these on its own frequent cadence at a triage level, but this periodic run is where a strategic callout gets its full comprehensive re-examination — see `[[00_README_Living_Reference_System]]`'s "Flagging questions, comments, and answers for Claude" section for how the two cadences relate.

If a callout genuinely can't be understood or answered confidently, leave it in place, reply directly beneath it with `> [!agent-comment]` / `> For [you]: <what's unclear and why>`, and flag it in your report — never silently delete an unanswered callout.

**Agent-comment sweep (things other skills flagged for you).** Also sweep the same notes for blockquote-form `[!agent-comment]` items whose first line starts `For <your-skill-name>:` — including a strategic callout `file-archive-audit` already triaged and queued for your comprehensive re-examination. Resolve each with the same professional-grade depth as a user-callout; remove the callout and log it.

**Writing your own agent-comment (things you noticed that belong to someone else's territory).** If you spot something needing a different skill's judgment — a cross-domain question, a document-hygiene issue that's `docs-quality-review`'s territory — write your own `> [!agent-comment]` / `> For <target-skill>: ...` at the spot instead of only noting it in your report.

**Questions only you can answer.** If this run turns up something only you can actually decide — a genuine preference, a missing-data proxy call, disambiguating intent — write `> [!agent-question]` / `> For [you]: <question, with options if there are natural ones>` at the spot. Never resolve one of your own or another run's `[!agent-question]` yourself — only a matching `[!user-answer]` beneath it does; when you find one, remove both callouts and log the resolution.

**Dedup before writing** — check for an existing unaddressed `[!agent-comment]`/`[!agent-question]` covering the same issue before adding a new one.

## Resolve pending Drive sync markers

Resolve `⚠ pending Drive sync` markers (the flag `file-renamer`'s filing step leaves when a just-filed document hasn't synced to Drive yet) via a Drive connector — replace with real Drive links if synced, else leave in place and report. Every File Archive reference should be a real Drive link, no exceptions — never leave a bare filename or path as a citation.

## Goals reconciliation

Your Goals notes (one per tracked person) are the "current state + strategy" summary you read, so they need to actually reflect what each domain review is finding, not just what File Archive syncs write into them. No single review should own the whole Goals note end-to-end — that's intentional, since the goals span every domain.

Read every tracked person's Goals note. For any goal or open item touching your domain, check it's still accurately stated against what you just verified in your main procedure, and update it if this run's findings changed the picture. Don't add generic content — only touch a Goals entry when this run's actual findings bear on it. One line in the Update Log noting what was reconciled (or "no changes needed").

## Don't cage answers

You're experienced enough in guiding your own health/finances/legal affairs to not follow advice blindly, and you'll verify with the appropriate professional when it matters. So a review shouldn't cage its answers — it should act as the professional your domain calls for and let you decide on execution. Give you the full, specific picture (real numbers, named tradeoffs, a recommended course where the analysis supports one) so you can make informed decisions, framed as "worth confirming with your [attorney/CPA/doctor]," never watered down to generic caution. Your mandate file's "Role and mandate" section states the exact framing for your domain.

## Format contract

Each domain's summary note is a **dashboard** — current state, strategy, open actions, Things To Watch — readable in a couple of minutes, no narration of how conclusions evolved. Reasoning, derivations, and definitional background go in that domain's `_Reference/` notes, `[[linked]]` from the actionable line rather than inlined; history goes only in the Update Log, never as narration in the body. Your mandate file's own Format contract section states exactly which notes play which role for your domain (some domains, like Health, benefit from a dashboard/detail split within `_Reference/` itself — see that mandate file).

Before finalizing any recommendation with multiple parts, check two things individual fact-checking won't catch on its own:

- **Sum-of-parts consistency** — recompute the aggregate effect of the full set of changes, not just each one in isolation, against the note's own stated risk framework or goals.
- **Best-practice/advisor-grade review** — check the recommendation against what the relevant professional would actually advise given this household's stated goals and constraints, not just "is each fact accurate."

## Report-back shape

Concise, no preamble. Confirm the full domain was re-verified this run (not just new documents) — name what was checked even if nothing changed. Then, in order: annotations resolved (and any that couldn't be), rule/law/science changes found (with source), domain-specific findings (your mandate file names what these are), Goals reconciliation (what changed, or "no changes needed"), documents read and synced directly this run (list what and why), filing gaps handed to `file-renamer` (confirm it actually ran, not just that it was identified), `[!agent-comment]`/`[!agent-question]` items resolved (addressed to you) or written (name the target — a skill or you), what's still open. One line if nothing needed changing, but still confirm the full re-verification happened.

## Update Log

*(Fresh install — nothing logged yet.)*
