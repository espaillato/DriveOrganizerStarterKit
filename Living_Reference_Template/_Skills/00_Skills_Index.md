---
tags: [system, meta, skills]
last_updated: 2026-01-01
---

# Skills — Index

This folder holds the full mandate for each vault-facing **skill**: something invoked directly by name (a slash command) or handed a task by another skill or a review, rather than something dispatched on its own schedule. See [[00_Reviewers_Index]] for the scheduled reviews — each scheduled task (`file-archive-audit`, `legal-review`, `financial-review`, `identity-review`, `health-review`, `docs-quality-review`) has its own mandate there instead.

`file-archive-audit` is the one review that's also a skill — it runs on its own frequent schedule *and* can be invoked directly ("file this for me," "sort my downloads"). Its mandate lives in [[File_Archive_Auditor_Mandate]] under `_Reviewers/` rather than here, since the scheduled-run side of its job is primary; this index just cross-references it for discoverability.

## The skills

| Skill | Invoked by | Mandate |
|---|---|---|
| `file-renamer` | Directly (interactive), or handed content-dependent renames and Living-Reference-drift syncs by `file-archive-audit` | [[File_Renamer_Mandate]] |
| `file-archive-audit` | Its own frequent schedule, or directly (interactive) | [[File_Archive_Auditor_Mandate]] (in `_Reviewers/`) |

## How this differs from `_Reviewers/`

Both folders exist so the actual behavior of every scheduled task and every vault-facing skill lives in the connected Living Reference folder itself — readable and editable directly in Obsidian — rather than only inside a skill package or a scheduled-task prompt that's harder to get to. The split is by dispatch mechanism, not importance: `_Reviewers/` is "runs on a schedule, is a subject-matter advisor or vault editor"; `_Skills/` is "runs on request or on hand-off, does a concrete job (file, rename, sync) rather than render judgment on a domain."

Each skill's saved copy (and, for `file-archive-audit`, its scheduled-task prompt) is a short bootstrap that points here — see the skill's own frontmatter for the pointer. Edit the mandate file directly for any change to what the skill actually does; only the bootstrap wrapper itself needs a skill-level update, which should be rare.
