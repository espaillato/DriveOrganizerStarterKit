---
tags: [health, reference, labs]
scope: <Name> only
last_updated: <YYYY-MM-DD>
---

# <Name> — Bloodwork Over Time

Standardized lab values pulled from every checkup document in `Health/<Name>/Checkups/` (or wherever your archive files them) that contains bloodwork, so patterns across years are visible in one place ahead of a doctor visit. Same test, different lab, different name — this table normalizes that. Raw label(s) as printed are shown in parentheses where they differ from the standard name.

**How to read this (standing format — `file-archive-audit` and your health review both keep this going forward, for every new draw added to this note):**

- **Range** = the single current clinical standard most applicable to this person specifically (age/sex-adjusted where relevant) — not each source lab's own printed reference interval, which varies by lab/assay and is dropped from the table (still on the linked source PDF if ever needed). One number/interval per test, not a spread of guideline variants.
- **✅** = optimal — only used where the guideline body actually names a distinct better-than-normal tier (e.g. LDL <100 "Optimal" vs. <130 "Near optimal," Vitamin D ≥30 "Optimal" vs. ≥20 sufficient, hs-CRP <1.0 "Low risk"). Not applied to tests without a named superior tier — those just go unflagged when normal.
- **↗️ / ↘️** = inside range but close enough to a boundary to be worth watching.
- **Bold + ⬆️ / ⬇️** = outside range.
- No explanatory text inside table cells. If a flag needs context, it gets a one-line callout under the table instead (see the format of the example callouts below).
- "—" = not tested that visit, not "normal."
- **Any table with a flagged value (⬆️/⬇️/↗️/↘️) also gets a short "What this could mean" callout** underneath — plain-language health context plus a specific sentence to say to a doctor, so this person can walk into an appointment naming a concern rather than just reading off a list of test names. Keep it to what's actually clinically relevant for that flag, not a general explainer of the test itself.

**Accuracy note:** extracted by reading each source document (including OCR/vision on scanned pages where needed). Spot-check flagged/abnormal values and anything feeding a Things To Watch item against the source first — if a number here is going to change a decision, pull the linked source document before relying on this table alone.

## Contents

- [[#Draws captured]]
- [[#Lipid Panel]]
- [[#Glucose / Diabetes]]
- [[#Liver Function]]
- [[#Kidney Function]]
- [[#Electrolytes / Minerals]]
- [[#CBC]]
- [[#Thyroid, Vitamins, Inflammation]]
- [[#Things worth raising with a doctor]]
- [[#Sources]]
- [[#Update Log]]

Add or drop body-system sections to fit what your actual source documents contain — this is a starting set, not a fixed schema. Split a section into multiple tables once one person has enough draws that a single table gets unwieldy.

## Draws captured

| Date | Source | Fasting |
|---|---|---|
| | | |

Note here if a single source document actually bundles more than one draw date (common with annual physical packets covering several visits) — break those out into their own rows by actual draw date rather than one row per document.

## Lipid Panel

| Test | Range | <date> | <date> |
|---|---|---|---|
| Total Cholesterol | | | |
| HDL Cholesterol | | | |
| Triglycerides | | | |
| LDL Cholesterol (calc) | | | |
| Non-HDL Cholesterol (calc) | | | |

**What the flag(s) could mean:** <plain-language context, plus a specific sentence to bring to the doctor, e.g. "Worth telling the doctor: '...'">

## Glucose / Diabetes

| Test | Range | <date> |
|---|---|---|
| Glucose (fasting) | | |
| HbA1c | | |

## Liver Function

| Test | Range | <date> |
|---|---|---|
| AST | | |
| ALT | | |
| GGT | | |
| Alkaline Phosphatase | | |
| Total Bilirubin | | |
| Total Protein | | |
| Albumin | | |

## Kidney Function

| Test | Range | <date> |
|---|---|---|
| BUN | | |
| Creatinine | | |
| eGFR | | |
| Uric Acid | | |

**What the flag(s) could mean:** <plain-language context, plus a specific sentence to bring to the doctor>

## Electrolytes / Minerals

| Test | Range | <date> |
|---|---|---|
| Sodium | | |
| Potassium | | |
| Chloride | | |
| CO2 | | |
| Calcium | | |
| Phosphorus | | |

<If a test's reference range varies unusually widely by lab/method (CO2/bicarbonate is a common example), note that explicitly and treat flags on it as soft — trending within the same lab matters more than a cross-lab standard.>

## CBC

| Test | Range | <date> |
|---|---|---|
| WBC | | |
| Hemoglobin | | |
| Hematocrit | | |
| MCHC | | |
| Platelets | | |

**What the flag(s) could mean:** <plain-language context, plus a specific sentence to bring to the doctor>

## Thyroid, Vitamins, Inflammation

| Test | Range | <date> |
|---|---|---|
| TSH | | |
| Free T4 | | |
| Vitamin D, 25-OH | | |
| CRP / hs-CRP | | |

<If the same analyte shows up under two different assay types (e.g. standard CRP vs. hs-CRP) across different documents, merge into one row and note the assay type inline with each value rather than keeping separate near-duplicate rows.>

## Things worth raising with a doctor

Sorted by importance, not by date. Each item should be something an actual flagged value or trend supports — not a general wellness suggestion. Update or remove an item once it's been addressed at an appointment rather than leaving it here indefinitely; note the resolution in the Update Log and, if there's an ongoing dashboard-level implication, in [[Health_Summary_<Name>]] as well.

- <Flagged value or trend, what it might mean, and the specific recheck/test/question it points to>

## Sources

List newest first. Link every source document to its real location (a Drive link, if that's where your archive lives) — never a bare filename.

- [<label — document description and date>](<link>)

## Update Log

- <date>: <what changed and why — e.g. "no new draw, corrected X range per updated guideline" or "added <date> draw, flagged Y">
