# Schemas and Report Template

Contents:
- Output layout
- `sources.csv`
- `symbols/*.jsonl` — symbol instance records
- `findings.jsonl` — friction findings
- Report template

Records are line-delimited JSON so that successive audit runs, and audits done by different faculty on different material, can be concatenated and counted without a database.

---

## Output layout

```
audit/
├── sources.csv                  one row per document audited
├── symbols/
│   ├── <source_id>.jsonl        symbol instances, one per line
│   └── ...
├── findings.jsonl               friction findings, one per line
└── report.md                    the human-facing write-up
```

---

## sources.csv

| column | notes |
|---|---|
| `source_id` | short stable slug, e.g. `3142-lec-unit3`, `mcquarrie-ch17`, `3141l-manual` |
| `title` | as it appears to students |
| `course` | `3141`, `3142`, `3141L`, `3142L`, `2141`, `prereq`, or `external` |
| `instructor` | or `n/a` |
| `type` | `lecture-notes`, `slides`, `textbook`, `jupyterbook`, `problem-set`, `exam`, `lab-manual`, `video`, `website` |
| `status` | `required`, `recommended`, `student-discovered`, `instructor-only` |
| `term` | e.g. `F2025`, `S2026` |
| `unit` | course unit or chapter range, if the source maps to one |
| `path_or_url` | |
| `extraction_method` | see `extraction.md`; e.g. `latex-source`, `pdf-text`, `pdf-raster-visual`, `docx`, `manual` |
| `extraction_confidence` | `high`, `medium`, `low` — drives how findings from this source are qualified |

---

## Symbol instance records — `symbols/<source_id>.jsonl`

One record per distinct symbol usage in a source. If a source uses one symbol consistently for one concept throughout, that is one record with a representative locator and an occurrence count — do not emit a record per printed occurrence. If a source uses a symbol for two things, that is two records.

```json
{
  "instance_id": "3142-lec-unit3:q:001",
  "source_id": "3142-lec-unit3",
  "glyph": "q",
  "latex": "q",
  "decoration": null,
  "concept_id": "PARTITION_FN_MOLECULAR",
  "concept_label_in_source": "molecular partition function",
  "defining_snippet": "q = \\sum_i g_i e^{-\\beta \\varepsilon_i}, the molecular partition function",
  "locator": "Unit III notes, p. 4, eq. 3.12",
  "units": "dimensionless",
  "convention_notes": "energy zero at the ground state",
  "occurrence_count": 23,
  "first_use_defined": true,
  "confidence": "high",
  "notes": ""
}
```

Field notes:

- `glyph` — the character as rendered, not a description. `ν` not "nu".
- `decoration` — `hat`, `overbar`, `tilde`, `bold`, `dot`, `prime`, `subscripted`, or a combination; `null` when bare. Kept separate from `glyph` so that F8 findings are queryable.
- `concept_id` — from `assets/concept_vocabulary.csv`, or `UNRESOLVED`, or a new ID you add to that file.
- `defining_snippet` — verbatim, short. This is the evidence.
- `first_use_defined` — whether the source defines the symbol at first use. Feeds the "silence" severity dimension.
- `confidence` — `low` when the glyph was read through lossy extraction and not visually verified.

---

## Finding records — `findings.jsonl`

```json
{
  "finding_id": "F-0007",
  "primary_code": "F2",
  "secondary_codes": ["F6"],
  "drift_subtype": "within-course",
  "concept_ids": ["HEAT", "PARTITION_FN_MOLECULAR"],
  "glyphs": ["q"],
  "summary": "q denotes both heat and the molecular partition function inside CHEM 3142 Unit III.",
  "evidence": [
    {
      "source_id": "3142-lec-unit3",
      "locator": "Unit III notes, p. 4, eq. 3.12",
      "snippet": "q = \\sum_i g_i e^{-\\beta \\varepsilon_i}",
      "reading": "molecular partition function"
    },
    {
      "source_id": "3142-lec-unit3",
      "locator": "Unit III notes, p. 19, eq. 3.44",
      "snippet": "\\Delta U = q + w",
      "reading": "heat"
    }
  ],
  "mitigated": false,
  "mitigation_note": "",
  "severity": {
    "frequency": 3, "span": 1, "co_occurrence": 2, "silence": 2, "exposure": 3,
    "total": 11, "tier": 2
  },
  "notes": "McQuarrie makes the same reuse; this is inherited from the text, not local."
}
```

Field notes:

- `evidence` needs at least two entries — a finding is a relationship between usages. A single-source internal inconsistency still yields two entries from the same `source_id`.
- `reading` states what the symbol means at that locator, so a reader can check the claim without reconstructing it.
- `mitigated` — true when at least one source explicitly warns students about the variation. Track these; they are the natural comparison group for any later study of explicit notation instruction.
- `notes` is the place for provenance — whether a collision originates in the required text, in local practice, or in the discipline at large. That distinction determines whether it is fixable locally.

---

## Report template

Use this structure in `audit/report.md`.

```markdown
# Notational Friction Audit — [corpus name]

## Scope
What was audited, what was not, and why. Number of sources by course and type.
Extraction confidence summary: how many sources were read from clean source
versus lossy extraction.

## Headline findings
The Tier 1 findings, one short paragraph each. State the collision, name the
sources, quote the evidence, and say whether it originates locally or in the
required text.

## Findings by code
Counts by primary code, then the findings themselves in tier order. Table form
is fine here; every row links to a finding_id in findings.jsonl.

## Cross-source patterns
Where friction concentrates: which course boundary, which unit, which source
pairing. This is the section that answers "where would a fix pay off most."

## Mitigated variation
Places where a source already flags a notational difference to students, with
the language used. Useful as a model, and as a baseline for measuring whether
explicit instruction helps.

## Limitations
Sources that could not be read, symbols left UNRESOLVED, formats where glyph
fidelity is uncertain, and anything the corpus excluded that would likely
change the picture.

## Suggested next passes
What to audit next to close the biggest gaps.
```

Keep the report readable by a colleague who has not seen the JSONL. The structured records exist for counting; the report exists for persuading.
