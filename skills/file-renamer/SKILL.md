---
name: "file-renamer"
description: "Rename and relocate files in your File Archive based on content and your Organization Philosophy. CRITICAL: Trigger this skill ANY time files in the File Archive are being renamed, moved, or reorganized — even if the user doesn't say \"rename.\" Also trigger for \"where does this go?\", \"what should I name this?\", \"file this for me\", poorly named files, or \"I downloaded a bunch of stuff, can you sort it?\" Works in single-file or batch mode. For files filed under a tracked person's Health or Identity folder, a joint Identity folder, your Legal trust-documents folder, or your Finance Institutions/Net_Worth/Investments folders, also syncs the corresponding Living Reference note; for lab-bearing Health documents, also updates that person's lab-trends reference note."
---

Read `Living Reference/_Skills/File_Renamer_Mandate.md` in full and follow it exactly. It holds your full role and the complete procedure: loading Organization_Philosophy.md, single-file vs. batch mode, reading/identifying files (including the OCR fallback and browser-saved-HTML-dump handling), naming, placement, the AUTO/FLAG/NEVER act-vs-ask split, splitting multi-document PDFs, and the full Living Reference sync protocol for Health/Identity/Legal/Finance documents (Steps 7/7b/7c).

This skill still ships its own bundled `scripts/strip_html.py` (used in the mandate's HTML-dump-cleaning step) — its base directory is printed as "Base directory for this skill" when this skill loads; the mandate file references it as "the skill's own base directory," which resolves correctly regardless of where the procedure text itself lives.

See `Living Reference/_Skills/00_Skills_Index.md` for how this skill fits with the vault's other skills and scheduled reviews.

If Living Reference or File Archive directory access is missing, request it for your own Living Reference and File Archive folders before proceeding.
