# Bootstrap Prompt

Copy everything in the box below into a Claude session that has access to your File Archive and Living Reference folders (see `SETUP_GUIDE.md` steps 1–5 first — this prompt assumes those are done). Fill in the bracketed placeholders before sending it. Claude will work through the steps interactively, asking you questions where a real decision is needed rather than guessing.

---

```
I've just set up a Living Reference / File Archive system using the starter kit at [describe where — e.g. "my Google Drive, in folders called File Archive and Living Reference"]. Please read Living Reference/00_README_Living_Reference_System.md and File Archive/Organization_Philosophy.md in full before doing anything else — those are the ground rules for this whole system.

Here's my household/situation:
- People to track: [list everyone, and the everyday name you want used for each in filenames]
- Domains I want tracked in Living Reference: [Health / Finance / Legal / Identity / other — list which ones actually apply to you]
- Anything unusual about my situation that the generic taxonomy might not anticipate: [e.g. a business entity, rental properties, multiple countries of residence, a blended family, no children, no trust/estate plan yet, etc.]

Please do the following, checking in with me at each numbered step rather than doing everything silently:

1. Propose specific edits to Organization_Philosophy.md's category table and any subfolder/naming conventions to fit my situation above. Show me the diff before applying it.
2. For each domain I listed, tell me which _Templates/ file to use as the starting point for my first real Living Reference note, and ask me whatever questions you need to fill in the frontmatter and the "Goals and mandate" / "Role and mandate" style sections that are supposed to reflect MY actual goals and situation (see especially the Financial_Reviewer_Mandate's "Operating model context" section and the Legal_Reviewer_Mandate's "state your own household's governing goal" instruction — these are placeholders in the generic kit that need real answers from me, not generic ones).
3. If I have existing documents ready to file, **build this up incrementally, not all at once** — dumping a large existing archive into `Unsorted/` and processing it in one pass risks burning through a large chunk of usage in a single session and makes mistakes harder to catch. Ask me roughly how many documents I'm starting with, then propose a batch size (a few dozen at a time is reasonable) and invoke file-renamer on just the first batch. Confirm it looks right before I hand you the next batch, rather than queuing everything up front.
4. Help me set up the scheduled tasks described in the README's "Scheduled reviews" section: file-archive-audit on a frequent cadence (recommend Monday/Wednesday/Friday unless I say otherwise), and one monthly review per domain I'm tracking, each on a different day so they don't collide. For each scheduled task, the prompt should be short — just tell it which mandate file to read and follow (e.g. "Read Living Reference/_Reviewers/Financial_Reviewer_Mandate.md in full and follow it exactly for this run.") — the actual behavior should live in that file, not be duplicated into the scheduled task's own prompt. Use whatever scheduling mechanism is available in this environment.
5. Once the above is in place, give me a short summary of what's been set up, what's still a placeholder I need to fill in myself, and what my very next action should be (e.g. "file your first batch of documents into Unsorted/").

Ask me one clarifying question at a time where you're not sure, rather than guessing and moving on — this is the one setup pass that's worth getting right, since everything after this runs on autopilot.
```

---

## Why this prompt is shaped this way

A few of the mandate files in `_Reviewers/` are deliberately left as placeholders that only make sense once you've stated your own household's actual goals and constraints — most notably:

- `Financial_Reviewer_Mandate.md`'s **Operating model context** section (your actual withdrawal rule, allocation policy, and how new money flows through your accounts).
- `Legal_Reviewer_Mandate.md`'s instruction to **state your own household's governing goal** (survivor protection, minimizing probate friction, a business succession plan, or whatever applies).
- Every domain review's **"Role and mandate"** framing, which assumes you'll adjust the exact professional "hat" (e.g. whether immigration/visa strategy applies to you at all) to your real situation.

These aren't bugs — they're the parts of the system that have to be personal to be useful. The bootstrap prompt above is designed to walk you through filling them in once, with Claude's help, rather than leaving you to discover mid-review that a mandate is giving generic advice because nobody ever told it what your actual goals are.

## Why filing happens incrementally, not all at once

This kit is meant to be dropped into an *empty* File Archive and grown from there — file a batch, let the vault update, file the next batch — not pointed at a fully-populated archive and asked to process everything on day one. Two reasons this matters:

- **Usage/token budget.** Reading, OCR'ing, and cross-referencing documents against Living Reference is real work per file. A few dozen files in a session is a normal, well-scoped task; a few hundred in one sitting risks exhausting a session's budget partway through, leaving the archive in a half-processed state that's harder to reason about than either "done" or "not started."
- **Review quality.** file-renamer and the domain reviews both do better work when there's a person actually checking their output along the way — a placement guess, a sync that misreads a document, or a masking mistake is much easier to catch and correct after 20 files than after 200.

If you're migrating years of existing documents into this system, expect it to take several sessions spread over days or weeks, not one afternoon — that's normal, not a sign anything's wrong.
