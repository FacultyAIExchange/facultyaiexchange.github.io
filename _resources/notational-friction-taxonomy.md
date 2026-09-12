---
title: A Classification of Notational Friction
summary: Nine categories for the ways notation itself — rather than the underlying content — obstructs students, with a diagnostic test for each and guidance on what not to flag.
resource_type: Classification framework
audience: Faculty auditing or coordinating course materials in symbol-heavy fields
context: Curriculum review, course coordination, materials development
format: Guide
faculty: Jay Foley
tags:
  - Teaching
  - Curriculum development
  - Notation
  - Course materials
---

Across instructors and textbooks, the same quantity or relationship gets written with different symbols, in different mathematical forms, under different conventions. An expert translates between them without noticing. A novice cannot tell whether unfamiliar notation is a different quantity, a different operation, a different convention, or something they already know written another way — and the effort spent deciding is effort not spent on the subject. We call that **notational friction**.

This classification came out of a physical chemistry faculty working group, but nothing in it is chemistry-specific. Any field where the same idea is written differently by different instructors has these nine categories.

The point of naming them is that they call for different responses. A synonym is cheap to fix and cheap to explain. A silent convention difference is neither. Lumping them together as "inconsistent notation" hides exactly the distinction you need in order to decide what to do.

## The nine categories

**F1 — Synonym: one concept, different symbols.**
*Diagnostic:* two sources denote the same quantity with different glyphs, with no difference in meaning. Boltzmann's constant as *k* or *k*<sub>B</sub>; Helmholtz energy as *A* in chemistry texts and *F* in physics texts; a box length as *l* in one chapter and *L* in the next.
*What it costs:* cheap to resolve if the student knows the two symbols are the same thing. The cost is not confusion so much as failure to transfer — a student who learned one form may not recognize that a problem in the other form is one they can already solve.

**F2 — Homonym: one symbol, different concepts.**
*Diagnostic:* the same glyph denotes different quantities in different places. Worst when both meanings live in the same unit. *T* for temperature and for a transmission probability; *n* for moles, for a principal quantum number, and for a reaction order; σ for a cross-section, a symmetry number, and a standard deviation.
*What to record:* whether the two meanings co-occur closely, and whether any source flags the reuse.

**F3 — Formalism: one concept, different mathematical form.**
*Diagnostic:* the symbols may agree, but the machinery differs — the student has to recognize an equivalence, not just perform a translation. An expectation value as an integral or in bra-ket notation; an entropy as *k* ln *W*, as −*k* Σ *p*ᵢ ln *p*ᵢ, or as δ*q*<sub>rev</sub>/*T*.
*What it costs:* the category most often mistaken for a conceptual gap. A student who cannot match a lecture's derivation to the textbook's different-looking one looks like a student who does not understand the concept.

**F4 — Convention: same symbol and form, different definitional commitment.**
*Diagnostic:* nothing on the page looks different, but a sign, a reference state, or an embedded factor differs. Δ*U* = *q* + *w* versus Δ*U* = *q* − *w*; a standard state of 1 bar versus 1 atm; two presentations of the same procedure with the roles of two symbol sets quietly reversed.
*What it costs:* the most dangerous category, because it is silent. A student can carry the wrong convention a long way without hitting a visible contradiction.

**F5 — Confusable: distinct symbols that are hard to tell apart.**
*Diagnostic:* different symbols for different quantities that are easy to conflate visually, phonetically, or in handwriting. ν and *v* — and both are spoken “vee”; ρ and *p*; ℓ, *l*, and the numeral 1; a symbol distinguished from another only by case, where the case distinction disappears between prose and code.
*Worth noting:* phonetic collisions never appear in the written record and are invisible to any audit of documents alone.

**F6 — Source drift: the same concept notated differently across the student's own sources.**
*Diagnostic:* an F1–F5 instance where the conflicting sources are both things your program hands students — instructor A versus instructor B, lecture versus its own lab, course notes versus the required text, one course in a sequence versus the next.
F6 is a tag applied *in addition to* an underlying code, not a replacement for it. It is also the thing a cross-source review can find and a single reader cannot, which is the reason to do this work systematically at all.

**F7 — Prerequisite drift.**
*Diagnostic:* your notation diverges from what students were taught in the prerequisite courses for the same concept. Δ-based treatments giving way to differentials and partial derivatives; calculus conventions for integration variables and limits; vector notation from physics against a scalar-heavy treatment; ln versus log habits.
Harder to audit, because prerequisite materials often sit outside whatever corpus you assemble. Record it when the divergence is visible from your side — for instance, when a source reintroduces a concept as though it were new.

**F8 — Decoration and typography.**
*Diagnostic:* the base glyph agrees, but its decoration is overloaded, inconsistent, or dropped. A hat meaning operator, unit vector, or estimator; an overbar meaning molar, time-averaged, or complex-conjugate; angle brackets meaning expectation value, ensemble average, or time average; boldface vectors that vanish on the whiteboard.
*Caution:* PDF text extraction routinely destroys exactly these features, so verify F8 findings visually before reporting them.

**F9 — Units and implicit dimensionality.**
*Diagnostic:* same symbol, same concept, different units or dimensional status, usually left implicit. Energies in J, kJ mol⁻¹, eV, or cm⁻¹ under one symbol; per-molecule versus per-mole quantities; rate constant units shifting silently with reaction order; a quantity named as a magnitude but dimensioned as its square.

Codes are not exclusive. A typical finding is F2 primary, F5 secondary, tagged F6. Record one primary code so frequency counts stay clean, and list the rest.

## What not to flag

A report's credibility depends on this as much as on its findings. Flagging benign variation floods the report and trains colleagues to ignore it.

- **Universally standard reuse.** Δ for a change, *d* for a differential, *x* for a variable. Flag these only when a source does something unusual with them.
- **Context-disambiguated homonyms that never co-occur.** Worth noting at low priority, with the reason for the low score stated, rather than dropped.
- **Font, italic, and rendering differences** that carry no meaning.
- **Genuine distinctions that only look like inconsistency.** Δ*H* and Δ*H*° differ for a reason.
- **Deliberate, flagged variation.** If a source tells students “the text writes this as *F*; we write *A*,” that is pedagogy, not friction. Count these separately — they are the natural comparison group if you ever want to test whether explicit notation instruction helps.
- **Notation appearing only in an optional resource nobody uses.** Report exposure honestly rather than inflating a count.

## Prioritizing what you find

A true finding is not automatically a finding worth acting on. Score each on five dimensions — **frequency** (how often the conflicting usages appear), **span** (how far apart the conflicting sources sit), **co-occurrence** (how close the conflicting meanings get — same unit? same equation?), **silence** (whether students are warned), and **exposure** (how many students meet it, how unavoidably) — and rank by the sum.

Two cautions from having used this.

The rubric assumes a corpus spanning several sources. On a single course, span and exposure barely vary, everything lands in one band, and the ranking stops discriminating. Score frequency, co-occurrence and silence alone in that case.

And record **origin** alongside severity: whether a finding is local practice you could edit this week, a convention inherited from the discipline where the only honest remedy is to warn students, or an outright error. That distinction is what colleagues actually act on, and it is not captured anywhere in a severity score.

Severity is a prioritization heuristic, not a measurement of student difficulty. Which variations actually cost students the most is an empirical question, and these tiers are candidate hypotheses for testing rather than answers.
