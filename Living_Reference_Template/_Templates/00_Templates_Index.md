---
tags: [system, meta, templates]
last_updated: <YYYY-MM-DD>
---

# Templates — Index

Two kinds of template live in this folder, matching the dashboard/detail split described in [[00_README_Living_Reference_System]]: **dashboard templates** (one per domain, live directly under `Living Reference/[Domain]/`) and **reference templates** (live under `Living Reference/[Domain]/_Reference/`, hold data/detail the dashboard synthesizes from or links to). Copy the one you need, fill in the placeholders, and drop it in the matching folder — file-renamer's sync steps and the domain reviews already know how to find and update these once they exist.

## Dashboard templates (one per person or per joint scope)

| Template | Use for | Goes in |
|---|---|---|
| [[Health_Summary_Template]] | Each tracked person's health dashboard | `Health/Health_Summary_[Person].md` |
| [[Identity_Summary_Template]] | Each tracked person's identity-document dashboard | `Identity/Identity_Summary_[Person].md` |
| [[Legal_Summary_Template]] | The shared estate-plan dashboard (usually one, joint) | `Legal/Legal_Summary_Joint.md` |
| [[Finance_Summary_Template]] | The shared accounts/net-worth dashboard (usually one, joint) | `Finance/Finance_Summary_Joint.md` |
| [[Goals_Template]] | Each tracked person's goals-tracking note | `Individual/Goals_[Person].md` |

## Reference templates (created as the need arises — not every household needs every one)

| Template | Use for | Goes in |
|---|---|---|
| [[Bloodwork_Trends_Template]] | Lab values over time, standardized across labs/years, with the flag-and-callout convention the dashboard's Vitals & Labs table also follows | `Health/_Reference/Bloodwork_Trends_[Person].md` |
| [[Medication_History_Template]] | Full medication record (active + discontinued), person-specific dangers/considerations, episode narratives | `Health/_Reference/Medication_History_[Person].md` |
| [[Health_Detail_Template]] | The live-edited detail note the Health dashboard is synthesized from — visit logs, the working Things To Watch checklist, advisory notes | `Health/_Reference/Health_Detail_[Person].md` |
| [[Renewal_Windows_Glossary_Template]] | Jurisdiction-specific renewal-eligibility rules feeding every Identity dashboard's "Renewal Eligible" column | `Identity/_Reference/Renewal_Windows_Glossary.md` |

These four ship as **blank format scaffolds only** — no pre-filled content. The actual facts (your lab ranges, your medications, your document renewal rules) are specific to you, so they're best built up by Claude as you file real documents and ask real questions, not guessed at in advance. What these templates lock in ahead of time is the *format* (flag conventions, callout style, sourcing discipline, table structure) — see [[00_README_Living_Reference_System]] for why the format is worth holding onto deliberately rather than letting each note's structure drift on its own.

Don't feel obligated to pre-create any reference note before you need it — [[File_Renamer_Mandate]]'s Step 7/7b create them on demand the first time a relevant document is filed, using these formats.

Other reference notes you'll likely end up creating that don't have a starter template here, because their content is entirely household- or topic-specific and is best generated fresh when the need actually arises: a Wearable_Trends note (if you track device data — follow Bloodwork_Trends' flag conventions), a longevity/healthspan strategy note, and any domain-specific glossary (a medical condition, a legal structure, a tax-analysis note) that a review creates once a topic needs its own space, per [[00_README_Living_Reference_System]]'s "Reference split" guidance — and a `<Note>_History.md` overflow file once any note's Update Log needs capping (see the same README's Update Log section).

## Update Log

- <date>: Starter-kit install.
