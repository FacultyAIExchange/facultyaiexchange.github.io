---
title: InspireHEP × LaTeX — Live Citation Data in Your Documents
summary: A LaTeX package that pulls High Energy Physics references, citation counts, and author metrics straight from INSPIRE-HEP, so a CV or proposal is never stale and never hand-typed.
faculty: Prof. Lawrence Lee
department: Physics & Astronomy, University of Tennessee, Knoxville
department_id: utk-physics-and-astronomy
audience: Researchers who maintain CVs, publication lists, and proposals in LaTeX
use_case: Scholarly writing, CV and proposal preparation
tools:
  - LaTeX
  - Python
  - pgfplots
  - INSPIRE-HEP API
  - GitHub Actions
  - Claude
tags:
  - Research
  - Scholarly writing
  - Bibliography
  - Automation
image: /assets/images/inspirehep-latex.png
repository_url: https://github.com/lawrenceleejr/inspirehep-latex
---

## What faculty used it for

Every CV sent out had citation counts that were already wrong by the time anyone downloaded it — assuming the numbers had been refreshed at all. This package removes that whole class of error. You hand a macro an INSPIRE record ID or texkey and it writes the full reference — authors or collaboration, title, journal, arXiv number — with a live citation count on the end. Hand it an author ID instead and you get LaTeX variables for the number of papers, total citations, h-index, and g-index, plus citation-trend plots drawn with pgfplots.

It also replaces the copy-and-paste round trip through INSPIRE's BibTeX export. `\inspirecite` is a drop-in substitute for `\cite`: give it an INSPIRE ID and the `.bib` file is assembled behind the scenes. The design goal was that you never handle a BibTeX key yourself.

The package is on CTAN. It works by fetching data on a first compilation with `-shell-escape` and then caching the results, so it behaves like a table of contents: two passes, and after that the document compiles anywhere with no network at all. A GitHub Actions workflow template is included for documents that should refresh themselves on a schedule, and there are notes on getting it working within Overleaf's constraints.

## Why it was useful

The tedious part of maintaining a publication record is the bookkeeping — and bookkeeping is exactly where hand-maintained numbers drift out of date and disagree with each other across documents. Pointing at a canonical record instead of transcribing from it means a CV, a progress report, and a proposal biosketch all quote the same figures, and all of them are current as of the last compile.

Statistics can also be aggregated across an arbitrary collection of papers, which is useful for describing a subset of one's work — a thesis topic, a single collaboration, a body of work under one award — as a coherent set rather than a list.

The package was written with substantial help from Claude, with the LaTeX interface and caching model designed deliberately and the implementation drafted by the AI.

## Materials to adapt

- The [inspirehep-latex repository](https://github.com/lawrenceleejr/inspirehep-latex), or a `tlmgr` install from CTAN.
- A LaTeX toolchain that permits `-shell-escape`, plus Python 3 (standard library only) for the helper script.
- Anyone outside high-energy physics would need to retarget the fetching layer at their own bibliographic database; the caching and two-pass structure is the reusable part.
