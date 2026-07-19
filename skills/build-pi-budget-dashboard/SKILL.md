---
name: build-pi-budget-dashboard
description: Guide a faculty member or PI through building a local-only grant-budgeting dashboard from reports their institution can export, using UTKGrantDashboard as the reference implementation. Use when someone wants to adapt this tool to another university's data or build a similar PI budget tool from scratch.
---

# Build a PI budget dashboard from institutional exports

Help a faculty member turn their institution's financial-report exports into a local dashboard that answers: *Am I on track? Where should I put new effort? What happens to each grant if I add a person?* [UTKGrantDashboard](https://github.com/trholmes/UTKGrantDashboard) is a complete working example built for the University of Tennessee's Oracle exports. Another institution's exports will differ; the process below is what transfers.

## Non-negotiable design rules

PIs are handling salary and grant data. Keep these defaults unless the user explicitly directs otherwise:

1. **Local-only.** Use a web server bound strictly to `127.0.0.1`, or generate a local file. Do not host the dashboard, including on GitHub Pages.
2. **Zero outbound requests.** Do not use CDN scripts, remote fonts, or analytics. The dashboard should work identically with Wi-Fi off.
3. **Data cannot be committed.** Store exports in a `data/` folder ignored by Git, while retaining only a short `data/README.md` in the repository.
4. **No dependencies.** Prefer the Python standard library and vanilla JavaScript so the code remains auditable and colleagues can run it with one command.
5. **Deterministic analysis.** Implement flags and projections as visible formulas in code, not model judgments. The same inputs should always produce the same outputs offline.

## Phase 1: inventory the data

Ask what the institution can export and obtain representative sample files before writing code. Map available reports onto two roles:

| Role | Must contain | Powers | Priority |
|---|---|---|---|
| Budget snapshot | Budget versus spending per award, ideally by category, with award dates | Award cards, balances, overspend flags, and the anchor for projections | Required |
| Transaction detail | Dated line items, ideally with names on payroll lines | Burn rates, spending history, salaries and fringe for staffing plans, support splits | Strongly recommended |

If no export contains budgets, ask for a budget-versus-actual or award-summary report. If transaction detail omits names, support manually entered people instead of blocking the project.

## Phase 2: inspect the exports

Institutional exports often contain non-obvious quirks. Check for:

- **Encoding and formats:** read CSV files with `utf-8-sig`; identify date, number, currency, and thousands-separator conventions.
- **Padding and duplication:** determine whether the reporting system has produced repeated rows or a Cartesian product. De-duplicate each logical record type and validate calculated sums against totals embedded in the report.
- **Cumulative versus dated data:** when only a snapshot is available, use award dates to compare percentage spent with percentage of time elapsed.
- **Stable file classification:** identify report types by their columns, not only by filenames or report numbers.
- **Useful fields:** look for indirect-cost rates, commitments, fringe lines, tuition and fees, and person identifiers.

## Phase 3: learn the institution's rules

Ask rather than assuming the reference implementation's rules:

- **Rebudgeting:** learn how much line items may deviate and use that allowance when grading flag severity.
- **Summer salary:** detect seasonal pay and avoid annualizing a short run of summer payments. Prefer a 12-month burn average when seasonality matters.
- **Fringe:** estimate actual rates from salary and fringe transactions when possible, and compare them with budgeted rates.
- **Facilities and administrative costs:** use an explicit rate from the report when available; otherwise infer and label an estimated rate. Learn which expenses are excluded from the cost base.

## Phase 4: build and verify in stages

Use the reference architecture: a small Python parser, analysis layer, and HTTP server bound to `127.0.0.1`; a browser interface written in vanilla JavaScript and CSS; and a Git-ignored local configuration file for scenarios.

1. **Parser and validation:** parse each report type and prove that totals agree with the reporting system before building analysis on top.
2. **Portfolio cards:** show time elapsed versus budget spent, category balances, monthly spending, and burn rate on comparable scales.
3. **Flags:** implement deterministic overspending, deadline, and pace rules whose severity reflects the institution's rebudgeting policy.
4. **Balance history and trend:** reconstruct prior month-end balances backward from today's known balance through dated transactions. Draw future trends from today rather than extrapolating them backward over lumpy history.
5. **People:** seed editable people and support splits from payroll records where possible. Estimate salary, fringe, and fees transparently.
6. **Planning:** support hires, departures, salary changes, and grant assignments. Keep scenario edits out of historical data.

## Verification norms

- Compare parsed sums with totals embedded in the source reports and tell the user the result.
- Inspect the rendered dashboard after visual changes, including dark mode, chart labels, and negative-currency formatting.
- Sanity-check surprising findings with the PI; their explanation may reveal another institutional rule or reporting quirk.
- Confirm that the server is bound only to `127.0.0.1`, the page makes no network requests, and the data directory is ignored by Git.

## Reference implementation

In [UTKGrantDashboard](https://github.com/trholmes/UTKGrantDashboard), `dashboard.py` contains parsing, analysis, and the local HTTP server; `static/` contains the interface and charts; and `README.md` documents the source reports and calculations. Adapt the parsers and institutional rules while preserving the security model.
