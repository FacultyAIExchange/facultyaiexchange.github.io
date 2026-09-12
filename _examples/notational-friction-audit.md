---
title: Notational Friction Audit for Physical Chemistry
summary: A skill file that walks an AI assistant through an evidence-based audit of course materials, finding the places where notation itself — not the physics — is what blocks students.
faculty: Jay Foley
department: Chemistry, University of North Carolina at Charlotte
department_id: uncc-chemistry
audience: Instructors of multi-semester sequences that lean heavily on symbolic notation
use_case: Curriculum audit, course materials review
tools:
  - Claude
  - Jupyter Book
  - Python
  - LaTeX
tags:
  - Teaching
  - Curriculum development
  - Notation
  - Course materials
image: /assets/images/notational-friction-audit.svg
skill_files:
  - name: Notational Friction Audit
    path: skills/notational-friction-audit/SKILL.md
    description: Guides an AI assistant through a two-pass inventory and cross-reference of the notation in a set of course materials, with a nine-code taxonomy, a severity rubric, and evidence rules.
---

## What faculty used it for

Physical chemistry asks students to read the same physical quantity under different symbols, in different mathematical forms, and under different definitional commitments, often inside a single term. An expert translates between these without noticing the effort. A novice cannot tell whether unfamiliar notation is a different quantity, a different operation, a different convention, or something they already know written another way — and the effort spent deciding is effort not spent on the chemistry. That is notational friction.

A working group of physical chemistry faculty is trying to classify it, find it in real course materials, and eventually remedy it. This skill file handles the finding.

It runs in two passes. First, an inventory: every symbol that carries physical meaning, one record per distinct usage, each with a source locator and a verbatim snippet. Then a cross-reference: normalize those records onto a shared vocabulary of concepts, and look for concepts carrying several symbols and symbols carrying several concepts. The second pass is where the value is, because friction is largely invisible inside a single document. A chapter that consistently writes *q* for the molecular partition function is internally fine. The problem only appears against the chapter that wrote *q* for heat.

What makes the output usable is mostly discipline about evidence. Every finding names a source, a locator precise enough to navigate to, and a verbatim quote; anything that cannot be traced to a specific line is discarded. The skill is explicitly forbidden from generating the classic textbook symbol clashes from general knowledge and presenting them as findings — if it is not in the corpus, it is not a finding. And the nine-code taxonomy carries a false-positive section, because a report that flags benign variation just teaches faculty to ignore reports.

## Why it was useful

We piloted it on the first three chapters of my CHEM 3141 Jupyterbook: 104 cells, 101 symbol instances, 23 findings, every one traceable to a notebook cell.

The finding I did not expect was in my own material. Chapter 3 gives the particle-in-a-box energy in both its ℏ and *h* forms and explicitly reconciles them — *“or, since ℏ = h/2π”* — which is exactly the kind of remediation this project has been circling. Twelve lines later, the code cell that plots the energy levels combines the numerator of one form with the denominator of the other. It is neither published expression, it is low by a factor of 4π², and the figure looked plausible enough to survive. These are materials I co-wrote and teach from, the translation between the two conventions is right there on the same screen, and I still never caught it.

That is the argument for this whole project, and I could not have made it from memory.

The larger pattern was also not what I would have guessed. Fourteen of the twenty-three findings sit inside a single chapter rather than across sources, and the ones that do cross chapters cluster at the boundaries where the author list changes. The most fixable friction in this corpus comes from multi-author assembly, not from the discipline. Sixteen findings are local practice we could edit tomorrow; four are inherited conventions where the only honest remedy is to warn students rather than change a symbol.

The pilot also found two problems with our own instrument. The severity rubric collapses on a single-course corpus, because two of its five dimensions cannot vary and everything lands in the same tier. And there is no field recording whether a finding is locally fixable, which turns out to be the distinction faculty actually act on. Both are now on the list to fix before the next pass — which is a reasonable thing to want from a pilot.

## Materials to adapt

- The [skill file](https://github.com/facultyaiexchange/facultyaiexchange.github.io/blob/main/skills/notational-friction-audit/SKILL.md) linked below, plus its `references/` and `assets/` folders. The packaged `.skill` bundle in the same directory installs in one step for anyone using Claude.
- A corpus with genuine overlap. Three documents that do not discuss the same material will produce nothing; three that approach it from different directions will produce plenty.
- Source format determines evidence quality, and the skill's extraction guide is blunt about it. LaTeX, Markdown and Jupyter sources are ground truth for glyphs. PDF text extraction silently eats hats, overbars and Greek letters — which is exactly the information this audit depends on — so equation-dense pages have to be read visually and the confidence recorded honestly.
- To adapt this outside physical chemistry, replace `assets/concept_vocabulary.csv` with your own field's quantities. The taxonomy, the evidence rules and the two-pass structure carry over unchanged; any field where the same idea is written differently by different instructors has this problem.

The division of labor is worth stating. The six-category classification at the core of the taxonomy came from the faculty group's own draft; a seventh code formalizes a note we had appended about prerequisite courses; two more were added by Claude to cover decoration and unit conventions that did not fit cleanly. Claude drafted the skill and ran the pilot. Deciding what counts as friction, and what is merely variation, stayed with us.
