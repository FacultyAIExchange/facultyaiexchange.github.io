---
title: UTK Budget Extractor — Spreadsheets to Proposal Documents
summary: A Python tool that turns a folder of institutional budget spreadsheets into DOE-ready justifications, LaTeX macros for every figure, and one merged workbook with formulas intact.
faculty: Prof. Lawrence Lee
department: Physics & Astronomy, University of Tennessee, Knoxville
department_id: utk-physics-and-astronomy
audience: PIs and administrators assembling multi-investigator funding proposals
use_case: Research administration, proposal preparation
tools:
  - Python
  - openpyxl
  - LaTeX
  - Excel
  - Claude
tags:
  - Research
  - Grant management
  - Proposal preparation
  - Automation
image: /assets/images/utk-budget-extractor.svg
repository_url: https://github.com/lawrenceleejr/UTKBudgetExtractor
---

## What faculty used it for

A multi-investigator DOE proposal arrives as a pile of institutional budget spreadsheets — one per faculty member, sometimes grouped by program — and every number in them has to reappear, correctly, in prose justifications, summary tables, and a consolidated workbook. Doing that by hand is transcription at scale, which means it is error-prone at scale.

Point this tool at the folder and it produces, for each input file, a set of LaTeX macro definitions covering every budget figure and an individual DOE budget justification. Across all inputs it produces combined definitions, a unified justification, faculty summary tables in both one-row-per-person and year-by-year form, a master driver document that aggregates the justifications, and a merged Excel workbook. The merge writes only user-input cells and never overwrites a formula, so the consolidated workbook stays live rather than becoming a flattened snapshot.

Two details matter more than they sound. Similar entries are consolidated where that is legitimate — graduate research assistants sharing a base salary, for instance — without losing cost accuracy. And when workbook-wide settings such as F&A rates or inflation assumptions disagree between input files, the tool warns rather than silently picking one.

## Why it was useful

Because every figure is emitted as a LaTeX macro into a dedicated `defs/` folder, updating numbers is decoupled from the proposal text. A budget revision three days before the deadline means re-running the extractor and recompiling; the edited prose is untouched. That separation is the difference between a routine update and a nervous re-read of the whole document.

The generated justifications and summary tables also enforce consistency in phrasing and formatting across investigators, which is the sort of uniformity reviewers notice and which is nearly impossible to maintain when several people draft their own sections.

Claude was used to write the extraction and merge logic against the specific quirks of UTK's budget spreadsheet format, working from human-specified rules about what may be consolidated and what must not be.

## Materials to adapt

- The [UTKBudgetExtractor repository](https://github.com/lawrenceleejr/UTKBudgetExtractor). Run it as `python -m utkbudget /path/to/budgets -o output_dir`.
- Python with `openpyxl`, and your institution's budget spreadsheets in `.xlsx` form.
- Adapting this elsewhere is mostly a matter of remapping cell locations to your own institution's template; the document generation, macro emission, and formula-preserving merge are independent of that layout. Work from a dummy budget in your institution's format if you would rather not send real figures to an AI service.
