# Friction Taxonomy

Contents:
- Codes F1–F9 with diagnostic tests and examples
- Assigning multiple codes
- False positives — what not to flag
- Severity rubric

Codes F1–F6 correspond to the faculty group's original six-category draft; F7 formalizes the prerequisite-course note appended to that draft; F8 and F9 were added because decoration and unit conventions in physical chemistry generate friction that does not fit cleanly in F1–F4.

---

## F1 — Synonym: one concept, different symbols

**Diagnostic:** Two sources denote the same physical quantity with different glyphs, with no difference in meaning.

**Examples to expect in this corpus:**
- Kinetic energy operator: $\hat{T}$ vs $\hat{E}_{kin}$ vs $\hat{K}$
- Boltzmann constant: $k$ vs $k_B$ vs $k_\mathrm{B}$
- Molecular partition function: $q$ vs $z$
- Helmholtz energy: $A$ vs $F$ (chemistry texts favor $A$, physics texts $F$)
- Molecular energy level: $\varepsilon_i$ vs $E_i$
- Reduced Planck constant: $\hbar$ vs $h/2\pi$ written out

**Why it costs students:** Cheap to resolve *if* the student knows two symbols are the same thing. The cost is not confusion so much as a failure to transfer — a student who learned $\hat{T}$ may not recognize a $\hat{K}$ problem as one they can already solve.

---

## F2 — Homonym: one symbol, different concepts

**Diagnostic:** The same glyph denotes different quantities in different places. Highest severity when both meanings live in the same course, and near-critical when they live in the same unit.

**Examples to expect in this corpus:**
- $q$ — heat (1st law) vs molecular partition function. Both fall inside CHEM 3142 Unit III per the syllabus.
- $Q$ — canonical partition function vs heat vs reaction quotient
- $W$ / $w$ — number of microstates in $S = k\ln W$ vs work
- $H$ — enthalpy vs Hamiltonian $\hat{H}$; a 3141→3142 collision
- $T$ / $\hat{T}$ — temperature vs kinetic energy operator
- $V$ — volume vs potential energy $V(x)$ vs $\hat{V}$
- $v$ — molecular speed (kinetic theory) vs vibrational quantum number
- $\nu$ — frequency vs stoichiometric coefficient
- $k$ — rate constant vs Boltzmann constant vs harmonic force constant
- $\mu$ — chemical potential vs reduced mass vs dipole moment
- $\sigma$ — collision cross-section vs symmetry number vs standard deviation (lab)
- $\alpha$ — polarizability vs degree of dissociation vs thermal expansion coefficient
- $n$ — moles vs principal quantum number vs reaction order
- $\Lambda$ — thermal de Broglie wavelength vs molar conductivity

**What to record:** whether the two meanings co-occur within a unit, and whether any source flags the reuse.

---

## F3 — Formalism: one concept, different mathematical form

**Diagnostic:** The symbols may match, but the mathematical machinery differs — the student must recognize an equivalence, not just a translation.

**Examples:**
- Expectation values: $\int \psi^* \hat{A} \psi \, d\tau$ vs $\langle \psi | \hat{A} | \psi \rangle$
- Particle in a box energy: $E_n = n^2h^2/8mL^2$ vs $E_n = \hbar^2\pi^2 n^2 / 2mL^2$
- Arrhenius: $k = Ae^{-E_a/RT}$ vs the linearized $\ln k$ form vs a $\log_{10}$ form
- Rate of reaction: $-d[A]/dt$ vs the unique-rate convention $(1/\nu_A)\,d[A]/dt$
- Entropy: $S = k\ln W$ vs $S = -k\sum p_i \ln p_i$ vs $dS = \delta q_\mathrm{rev}/T$
- Derivative notation: $dy/dx$ vs $y'$ vs $\dot{y}$; partial vs total differentials written loosely

**Why it costs students:** This is the category most often mistaken for a conceptual gap. A student who cannot match the lecture's bra-ket derivation to the textbook's integral one looks like they do not understand expectation values.

---

## F4 — Convention: same symbol and form, different definitional commitment

**Diagnostic:** Nothing on the page looks different, but a sign, reference state, or embedded factor differs. The most dangerous category, because it is silent — a student can carry the wrong convention a long way without a visible contradiction.

**Examples:**
- Work sign: $\Delta U = q + w$ (chemistry) vs $\Delta U = q - w$ (engineering/some physics)
- Standard state pressure: 1 bar vs 1 atm; $^\circ$ vs $^\ominus$ notation
- Zero of energy: bottom of the well vs the $v=0$ level in vibrational partition functions
- Extensive vs molar quantities under the same symbol; overbar sometimes present, sometimes assumed
- Wavenumber $\tilde{\nu}$ in cm$^{-1}$ vs angular frequency $\omega$ vs $\nu$ in s$^{-1}$, and where factors of $2\pi$ or $c$ are absorbed
- $\beta \equiv 1/kT$ introduced without restatement
- Equilibrium constant defined in pressures, concentrations, or activities under an unsubscripted $K$

**What to record:** the exact defining sentence or equation from each source, verbatim. Convention findings are contested by faculty more than any other category, and the quotation is what settles it.

---

## F5 — Confusable: distinct symbols that are hard to tell apart

**Diagnostic:** Two different symbols for two different quantities that are visually, phonetically, or handwriting-wise easy to conflate.

**Examples:**
- $\nu$ vs $v$ — frequency vs speed/vibrational quantum number, and both are spoken "vee" in some lectures
- $\rho$ vs $p$ — density vs pressure or momentum
- $\kappa$ vs $k$ vs $K$
- $\epsilon$ vs $\varepsilon$ vs $E$
- $\ell$ vs $1$ vs $l$
- $\omega$ vs $w$
- $\Phi$ vs $\phi$ vs $\varphi$ used inconsistently for the same or different things

**Also record the spoken form** where lecture video or in-class practice is part of the corpus. Phonetic collision is real friction and never appears in the written record.

---

## F6 — Source drift: the same concept notated differently across the student's own sources

**Diagnostic:** An F1–F5 instance where the conflicting sources are both part of what this program hands students — instructor A vs instructor B, lecture vs lab, lecture vs required text, 3141 vs 3142, majors sequence vs the CHEM 2141 survey.

F6 is a tag applied *in addition to* the underlying code, not a replacement for it. It is also the code the audit exists to populate — it is precisely what a cross-source inventory can find and a single reader cannot.

**Subtypes worth distinguishing in the `notes` field:**
- `within-course` — same course, different weeks or different instructor sections
- `lecture-lab` — lecture vs its coordinated lab
- `course-text` — course materials vs the required textbook
- `sequence` — 3141 vs 3142, or majors vs survey
- `course-external` — course materials vs a recommended or widely-used outside resource

---

## F7 — Prerequisite drift

**Diagnostic:** Physical chemistry notation diverges from what students were taught in CHEM 1251/1252, introductory physics, or calculus for the same concept.

**Examples:**
- $\Delta$-based general chemistry thermodynamics vs differential and partial-derivative formulations
- Integration variable and limit conventions between calculus and thermodynamic path integrals
- Vector notation from physics vs the scalar-heavy chemistry treatment
- Rate law conventions from general chemistry vs the fuller kinetics treatment
- $\ln$ vs $\log$ habits carried from general chemistry

Harder to audit than F6 because prerequisite materials may sit outside the corpus. Record it when the divergence is visible from the PChem side — e.g. a source that reintroduces a concept as if it were new.

---

## F8 — Decoration and typography

**Diagnostic:** The base glyph agrees but its decoration is overloaded, inconsistent, or dropped.

**Examples:**
- Overbar meaning molar, time-averaged, or complex-conjugate depending on context
- Hat meaning operator, unit vector, or estimator
- Operator hats dropped in handwritten notes but present in the text
- Angle brackets for expectation value vs ensemble average vs time average
- Subscript vs superscript placement for standard state, initial state, and equilibrium
- Boldface vectors that vanish on the whiteboard

Extraction-sensitive: PDF text extraction routinely destroys exactly these features. Verify F8 findings visually before reporting them.

---

## F9 — Units and implicit dimensionality

**Diagnostic:** Same symbol and same concept, but different units or dimensional status, usually left implicit.

**Examples:**
- Energies in J, kJ mol$^{-1}$, eV, cm$^{-1}$, or hartree under the same symbol
- Per-molecule vs per-mole quantities ($k$ vs $R$, $\varepsilon$ vs $E_m$)
- Rate constant units shifting silently with reaction order
- Pressure in bar, atm, Pa, or torr within one problem set
- Dimensionless equilibrium constants vs ones carrying units

---

## Assigning multiple codes

Codes are not exclusive. A typical finding looks like: primary code F2, secondary F5, tagged F6/`sequence`. Record a single `primary_code` for counting and a `secondary_codes` list for nuance, so frequency tallies stay clean for Research Question 1.

---

## False positives — do not flag these

The report's credibility depends on this section as much as on the findings.

- **Universally standard reuse.** $\Delta$ for change, $d$ for differential, $x$ for a variable. Flag only if a source does something unusual with them.
- **Context-disambiguated homonyms with no co-occurrence.** $T$ for temperature in 3142 and $\hat{T}$ for kinetic energy in 3141 is worth noting only if a source uses both nearby or if the hat is unreliable in practice. Score it low rather than dropping it, and say why it scored low.
- **Font, italic, and rendering differences** that carry no meaning.
- **Genuine physical distinctions** that only look like inconsistency — $\Delta H$ vs $\Delta H^\circ$ differ for a reason.
- **Deliberate, flagged variation.** If a source explicitly tells students "the text writes this as $F$; we write $A$," that is pedagogy, not friction. Record it as a mitigated instance — these are worth counting separately, because they are evidence about what Research Question 3 proposes.
- **Notation appearing only in an optional resource nobody uses.** Note exposure honestly rather than inflating the count.

---

## Severity rubric

Score each dimension 0–3, sum for `severity_total` (max 15).

**Frequency** — how often the conflicting usages appear across the corpus.
0 isolated · 1 occasional · 2 recurring within a unit · 3 pervasive across units

**Span** — how far apart the conflicting sources sit.
0 single source, internally inconsistent once · 1 two sources, same course · 2 across lecture/lab or course/text · 3 across the course sequence or into prerequisites

**Co-occurrence** — how close the conflicting meanings get.
0 different courses, different semesters · 1 same course, different units · 2 same unit · 3 same derivation, page, or equation

**Silence** — whether students are warned.
0 explicitly flagged and translated in a source · 1 mentioned in passing · 2 not mentioned · 3 not mentioned and the two usages are presented as if unrelated

**Exposure** — how many students meet it and how unavoidably.
0 optional resource · 1 recommended resource · 2 required text or assigned problem set · 3 lecture, exam, or lab material students cannot avoid

**Tiers:** 12–15 Tier 1 (address first) · 8–11 Tier 2 · 4–7 Tier 3 · 0–3 Tier 4 (record only).

Severity is a prioritization heuristic, not a measurement of student difficulty. Research Question 2 asks which variations actually cost students the most, and that is an empirical question this rubric cannot answer. Present the tiers as candidate hypotheses for the group to test, and say so in the report.
