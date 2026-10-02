---
name: jupyterlite-course-site
description: Turn an instructor's existing Python/Jupyter course notebooks into a JupyterLite site that students run entirely in their web browser, with nothing to install and no server. Use this skill whenever a faculty member asks to put notebooks online for students, mentions JupyterLite, "Jupyter in the browser", a "no-install" or "zero-setup" way to run Python activities, an alternative to Google Colab or a JupyterHub, or GitHub Pages for a course; whenever they say their students struggle with installing Python; and whenever they want existing notebooks audited for browser compatibility, a local demo of such a site, or the site published. Chemistry and physics courses are the reference cases, but any Python notebook course applies.
---

# Build a Jupyter Site for Your Course

## What this is for

A JupyterLite site is a folder of static files. Students open a web address, see a Jupyter file browser, and run notebooks with a Python that lives in their browser (Pyodide). Nothing is installed, no server runs, and hosting on GitHub Pages is free. The catch is that a browser Python is not a laptop Python: some packages don't exist, files and the network behave differently, and a few notebook habits break. This skill takes an instructor from "here are my notebooks" to a site they have seen working, with every change to their material explained.

The instructor is the expert on their course. You are the one who knows what breaks in a browser. Keep that division: propose, explain, and ask; never change what students are taught without a decision from the instructor.

## Non-negotiable rules

1. **Solutions never enter the site.** Everything in the site's content folder is world-readable the moment it is published. Instructor versions, answer keys, and autograder files stay outside the repository. Refuse to copy them in, and add the safety net in `assets/gitignore` to the repository.
2. **Nothing outward-facing without an explicit go-ahead.** Creating a repository, pushing, enabling GitHub Pages, and deleting or overwriting anything the instructor made all require the instructor's confirmation for that specific action. Never handle GitHub tokens or passwords; the instructor logs in themselves.
3. **Pin every version, and prefer the tested set.** JupyterLite, its Python kernel, and the widget packages must be pinned together, and the pinned set is frozen for the semester. Start from the known-good set in `references/compatibility.md`. Check PyPI for newer releases, but adopt them only if the tested set is more than about six months old or lacks something the course needs, and then re-verify in a browser (Phase 3) before relying on them. Newer is not better here; tested is.
4. **Every finding cites evidence.** An audit finding names the notebook and cell, quotes the line, says why it matters in a browser, and proposes a fix. No finding without a location.
6. **Autograding is out of scope.** If notebooks carry nbgrader metadata, Otter-Grader blocks, or `grader.check` cells, say so, explain that the site serves whatever student version those tools produce, and offer to help with the grading workflow as a separate task.

## Workflow

### Phase 1: interview

Reading notebooks and running the audit script change nothing, so the audit may come first; if the instructor asks for the audit before anything else, do that and fold the interview questions into the audit's decision list, so there is still one round. Either way, keep it to one round of questions, grouped:

- **The notebooks.** Where they are, whether the folder contains instructor or solution versions that must be excluded, and whether data files and images live with them.
- **Submission and machines.** How students will hand in work (this shapes the student handout and the "download your notebook" instruction), and whether they work on shared or lab computers, where browser storage can be wiped at logout (this sharpens the data-loss warning). Nothing else about the students changes what gets built.
- **Interface.** Classic Notebook (one notebook per browser tab, simpler for novices) or JupyterLab (all notebooks in one tab with a file panel). Note one fact from testing: in the classic interface every browser tab is titled with the site's name, not the notebook's, so instructors who expect students to have many notebooks open may prefer Lab. Default to classic for introductory courses.
- **Plots.** Static figures only, pan/zoom, sliders, rotatable 3D surfaces, or molecular viewers. The audit usually answers this better than the instructor can (it sees the plotting calls and the old backend lines), so ask it as a confirmation. It determines which packages the site bundles; see `references/compatibility.md`.
- **Hosting.** Local demo only for now, or publish to GitHub Pages. If publishing: which GitHub account or organization, and whether the site should be kept out of search engines (default yes).
- **Layout.** Weekly folders, one folder per unit, or flat.

Record the answers; several later choices depend on them.

### Phase 2: audit

Run `scripts/audit_notebooks.py` on the folder (add `--interactive` if the course will use the interactive plot backend; `--offline` skips network lookups; `--cache-dir` moves its one cache file, which otherwise lives under `~/.cache`). It scans every notebook and prints, per notebook: imports checked against the pinned Pyodide's package list, with transitive dependencies and the PyPI author for anything not built in (an "unknown" package may be the instructor's own module; compare with what they told you); functions removed from current NumPy and Matplotlib; backend lines, magics sharing a cell with imports, and plotting cells that would draw into a previous figure under the interactive backend; file and network access; remote images with a liveness check; data files not where they are loaded from, files nothing names, and hidden files; environment-specific wording such as JupyterHub or Validate; solution and autograder markers; cells that don't parse.

Then read `references/audit-checklist.md` and judge what the scan found. The script reports; you decide what matters and what to propose. Write the audit as a report for the instructor, in the chat and also saved as a file in your working folder: a summary table, then findings with location, evidence, why it matters in a browser, and the proposed fix. A finding that repeats across notebooks, or spans several (a save/upload workflow, the closing "Validate and Submit" instructions), is stated once in a course-wide section and referenced per notebook. Four grades:

- **Stop:** must never enter the site, such as a solution file.


- **Blockers** that will fail in the browser: a compiled package absent from Pyodide, a download from a site that forbids browser access, a file format the browser Python can't read.
- **Adaptations** the site needs: plot backend lines, magics sharing a cell with imports, data-file locations, remote images, captions that render beside their image in wide layouts.
- **Notes** that need no action: intentional student blanks, cells that error by design, packages that install at runtime.

Ask which fixes to apply. Some, like replacing a package, are pedagogical decisions.

### Phase 3: local demo

Build the site on the instructor's computer before anything is published. This is the step that convinces people, and it needs no GitHub account.

1. Create a dedicated Python environment for building (a conda environment or venv), install the pinned build stack from `assets/requirements.txt` after refreshing its versions, and add any front-end packages the plots need (the widget backend and Plotly must be installed in the *build* environment so their browser extensions are picked up).
2. Scaffold the site folder with `scripts/scaffold_site.py`, which copies the templates in `assets/`, sets the interface and site name from the interview, and downloads the runtime wheels the notebooks need into `pypi/`.
3. Copy the notebooks in, adapted or not yet, plus their data files and images. Never the solutions.
4. Build and serve:
   ```
   jupyter lite build --contents content --output-dir _output
   cd _output && python -m http.server 8000
   ```
   Run the server in the background (`(cd _output && python -m http.server 8000 &)`) and confirm with `curl -sI http://127.0.0.1:8000/`, since your turn has to continue. The scaffold puts the smoke test in `tests/`; include it in local builds with `--contents content --contents tests`. For a rebuild after changing the site configuration, delete both `_output` and `.jupyterlite.doit.db` first. Deleting only the output folder leaves a stale cache, the configuration merge is skipped, and the site silently comes up in the wrong interface.
   The build environment must contain only what the course needs: every Jupyter extension installed in it is copied into the site. Students need internet on first load in each session, because the browser downloads Python itself from a CDN (about 30 MB, then cached).
   If the audit's decisions are already in hand, adapt first (Phase 4) and build the adapted notebooks directly; building the unadapted ones only adds a round.
5. Give the instructor the address and a checklist: open the smoke-test notebook and, in each of their notebooks, Kernel > Restart Kernel and Run All Cells. In a fill-in-the-blank course Run All stops at the first blank, so tell them to fill blanks in as a student would or step past them. Ask them to use a fresh private browsing window each time the site is rebuilt, because the browser keeps its own copy of any notebook already opened, including its outputs.

### Phase 4: adapt the notebooks

With the instructor's decisions from the audit, apply the mechanical fixes with `scripts/adapt_notebooks.py`. It writes converted copies to a new folder and a change log, outside that folder so students never see it, listing every edit by notebook and original cell number so the instructor can mirror changes in their masters. `--backend widget|keep|static` sets the plot policy; `--ensure-figure` inserts `plt.figure()` in plotting cells that would otherwise draw into a previous figure under the interactive backend (off by default because it edits cells students read; the log lists every insertion either way). It also handles install cells, magics that share a cell with imports, `!pip`, remote images (downloaded next to the notebooks when the server returns an image, failures reported), captions, data-file placement without duplicates, hidden files (not copied), cleared outputs, and kernel metadata. Anything beyond that, such as a slider callback that must be restructured, a removed function like `np.trapz` renamed, or a package replaced, you edit by hand and add to the log.

Show the instructor the log. Then rebuild the demo and have them check again.

### Phase 5: publish (optional)

Only when the instructor asks, and only after the local demo passed.

1. The instructor runs `gh auth login` themselves. Confirm with `gh auth status`.
2. Create the repository (public, since GitHub Pages on private repositories needs a paid plan), add the site folder with the deploy workflow from `assets/deploy.yml`, confirm the `.gitignore` is in place, and check that no instructor file is staged. Show the file list before the first commit.
3. Push, enable Pages with GitHub Actions as the source, wait for the workflow, and give the instructor the address to verify in a private window.
4. Explain the publishing rhythm: pushing to the main branch is publishing; a notebook students have already opened will not update in their browser, so a fixed notebook goes out under a new filename.

Details and commands are in `references/site-recipe.md`.

### Phase 6: hand-off

Write two short documents from the templates in `references/guides.md`: an instructor guide (`README.md` of the site folder: how to add notebooks, preview, publish or publish later, and what never to change mid-semester) and a student handout. Put the handout in `content/` as a notebook with a name that sorts first, since a Markdown file opens as plain text in the classic interface. Fill both in with the instructor's actual choices.

## What the instructor should walk away with

- A site they have seen their own notebooks run on.
- A change log for every notebook that was touched.
- A pinned, reproducible build they can repeat next semester.
- The two documents from Phase 6.

## Files in this skill

- `references/audit-checklist.md`: what to look for, why each thing matters in a browser, and the fix. Read before writing an audit.
- `references/compatibility.md`: browser-verified results for plotting and widget libraries, which common chemistry and physics packages are available, how to check the package list for a given Pyodide version, and a known-good pinned set with its test date.
- `references/site-recipe.md`: the site's files, building, serving, rebuilding, bundling wheels, publishing to GitHub Pages, and verifying.
- `references/guides.md`: templates for the instructor guide and the student handout.
- `assets/`: `requirements.txt`, `jupyter-lite.json`, `deploy.yml`, `gitignore`, `robots.txt`, `smoke_test.ipynb`.
- `scripts/audit_notebooks.py`, `scripts/adapt_notebooks.py`, `scripts/scaffold_site.py`.
