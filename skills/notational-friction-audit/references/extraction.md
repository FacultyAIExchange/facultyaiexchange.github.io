# Extraction Guidance

Contents:
- The central risk
- Format-by-format handling
- Verification pass
- Sampling when the corpus is large
- Recording extraction quality

---

## The central risk

This audit's unit of analysis is a glyph and its decoration. Those are exactly the features that text extraction destroys most readily. A pipeline that reads `nu` where the page shows $\tilde{\nu}$, or drops the hat from $\hat{T}$, produces an inventory that is precise, well-structured, and wrong — and wrong in a way that manufactures false findings while hiding real ones.

So: prefer sources where the mathematics is machine-readable, verify visually where it is not, and record extraction quality on every source so the report can qualify its own claims.

---

## Format-by-format handling

### LaTeX, Markdown with math, Jupyterbook, Quarto

Best case. The author's own markup is ground truth for glyph and decoration. Read the source files rather than the rendered output.

For a Jupyterbook served as HTML, look for the underlying `.md` or `.ipynb` in the repository first. Rendered MathJax output is workable but noisier. The CHEM 3141 Jupyterbook is authored by the instructors, which also makes it the most useful source in the corpus for establishing what local practice *intends* to be.

Extract math by pattern-matching delimiters (`$...$`, `$$...$$`, `\[...\]`, `\begin{equation}`), then read the surrounding prose for the defining sentence. The prose matters as much as the math — `defining_snippet` should usually include the sentence that says what the symbol is.

Record `extraction_method: latex-source`, confidence `high`.

### Native-text PDFs (typeset textbooks, syllabi, typed notes)

Extract text first for structure and prose, but do not trust it for glyphs. Common failures: Greek letters mapped to Latin lookalikes or lost entirely, superscripts and subscripts flattened into the baseline, hats and overbars dropped, ligatures and math fonts producing garbage, and two-column or boxed layouts scrambling reading order.

Workflow that holds up:
1. Extract text to locate the equation-dense regions and get page numbers.
2. Rasterize those pages to images and read them visually to confirm glyphs, decorations, sub/superscripts, and equation numbers.
3. Populate `glyph` and `decoration` from the visual pass, prose from the text pass.

Do not rasterize the whole book. Target the pages where symbols are introduced — the audit cares about defining moments far more than about repeat usage.

Record `extraction_method: pdf-text` if step 3 was skipped (confidence `medium` at best), `pdf-raster-visual` if the visual pass happened (confidence `high` for the pages checked).

### Scanned or handwritten notes, tablet notes, whiteboard photos

Rasterize and read visually; there is no text layer worth using. Expect real ambiguity — handwritten $\nu$ versus $v$, $\rho$ versus $p$, and dropped operator hats are common, and this is precisely the F5 and F8 territory the audit is looking for.

When a glyph is genuinely ambiguous in handwriting, that ambiguity *is* a finding. Record the instance with `confidence: low` and a note describing what makes it ambiguous, rather than picking the likelier reading silently.

### PowerPoint and Keynote decks

Text extraction gets speaker notes and text boxes; equations are frequently images, or built with an equation editor that extracts poorly. Pull the text, then render or view the slides that contain equations. Slide numbers make good locators.

### Word documents

Equations may be OMML (recoverable), images (rasterize), or typed characters with manual formatting (recoverable but often with subscript formatting lost in plain extraction). Check which before trusting the output.

### Video and lecture recordings

Two channels, both useful. Transcripts capture the spoken form of symbols — the "vee" problem is only visible here — while the visual channel captures what is written. Where only a transcript exists, record spoken forms with a note that written glyphs were not verified, and use timestamp locators.

### Websites and external resources

Capture the URL and an access date; these change. For material students actually use rather than material assigned to them, note how it entered the corpus — student report, instructor observation, or assumption. Research Question 4 turns on this being honest.

### Problem sets, exams, and lab manuals

Do not skip these for being short. Assessment material is where notation becomes consequential, and lab manuals are frequently maintained separately from lecture, which makes them a rich F6 `lecture-lab` source.

---

## Verification pass

Before writing findings, spot-check the inventory:

- Pull every record with `confidence: low` and decide whether the underlying page can be visually re-read.
- Pull every `UNRESOLVED` concept mapping and try once more with more surrounding context.
- Check the highest-count glyphs against the source visually. An error in a high-frequency symbol contaminates many findings.
- Check that decorations survived — if an entire source has `decoration: null` everywhere, the extraction almost certainly ate them.

That last check catches the most damaging silent failure in this pipeline.

---

## Sampling when the corpus is large

A full inventory of a 700-page textbook is rarely the right first move. Sample deliberately and document the sampling rule in the report:

- **Definitional sampling** — chapters or sections where symbols are introduced. Highest yield per page.
- **Overlap sampling** — the chapters both courses assign, and the units where two courses treat the same material.
- **Assessment sampling** — every exam and problem set, in full. These are short and consequential.
- **Boundary sampling** — the end of 3141 and the start of 3142; lecture and lab for the same week.

Say what was sampled, so nobody reads a partial count as a total one.

---

## Recording extraction quality

Every source carries `extraction_method` and `extraction_confidence` in `sources.csv`, and every symbol instance carries its own `confidence`. When a finding rests on any low-confidence instance, say so in the finding's `notes` and in the report. An audit that is candid about what it could not read is far more useful to this group than one that is uniformly confident.
