---
title: Local Grant Budget Dashboard for PIs
summary: An AI-assisted, local-only dashboard that turns institutional finance exports into grant projections, spending alerts, and hiring scenarios without sending sensitive data off the faculty member's computer.
faculty: Dr. Tova Holmes
department: Physics and Astronomy, University of Tennessee, Knoxville
audience: Principal investigators and research-group leaders managing sponsored awards
use_case: Research administration
tools:
  - AI coding assistant
  - Python
  - JavaScript
  - Institutional CSV exports
tags:
  - Research
  - Grant management
  - Data privacy
  - Decision support
image: /assets/images/local-grant-budget-dashboard.png
repository_url: https://github.com/trholmes/UTKGrantDashboard
skill_files:
  - name: Build a PI Budget Dashboard
    path: skills/build-pi-budget-dashboard/SKILL.md
    description: Guides an AI coding assistant through adapting the dashboard to another institution's exports and financial rules.
---

## What faculty used it for

The faculty lead used an AI-assisted coding workflow to turn exports from the university's financial reporting systems into a practical portfolio dashboard for principal investigators. The dashboard shows budget, spending, commitments, remaining funds, monthly burn rate, and runway for each award. It also flags potential problems such as overspent categories, charges against zero-budget lines, awards ending with substantial funds unspent, and spending that is on pace to overrun.

The People table supports forward planning that the institutional reports do not provide. It can model a new hire, a student's expected graduation, a change in salary, or a person's support split across grants. Those edits flow into projections that account for salary, fringe, tuition and fees, and each award's facilities and administrative cost rate.

## Why it was useful

The dashboard brings several large, difficult-to-compare reports into one decision-oriented view. Instead of reconstructing the same calculations in spreadsheets, a PI can reload fresh exports and quickly see which awards need attention and whether a staffing plan is sustainable.

The privacy model is especially important for salary and sponsored-project data. The application runs only on the faculty member's computer, makes no outbound network requests, and keeps data files out of version control. AI is used to help build or adapt the tool; the financial analysis itself uses transparent, deterministic formulas and does not send institutional data to an AI service.

Because the implementation uses only the Python standard library and browser-native JavaScript, colleagues can audit and run it without installing additional packages. The accompanying skill file turns the project into a reusable method: it asks an AI coding assistant to inventory local exports, validate their quirks and totals, learn institution-specific rules, and then adapt the reference implementation.

## Materials to adapt

- The [UTKGrantDashboard source repository](https://github.com/trholmes/UTKGrantDashboard), which includes fictional demo data and a reference implementation.
- A budget-versus-actuals export for each award, including award dates and expenditure categories.
- A transaction-detail export with dates and, where available, payroll, fringe, commitment, and indirect-cost information.
- Local rules for rebudgeting, fringe, summer salary, tuition and fees, and facilities and administrative costs.
- The related skill file linked below, plus representative sample exports that an AI coding assistant can inspect safely under the institution's data-handling policies.

Real grant and payroll exports may contain sensitive information. Faculty adapting this workflow should use an approved AI environment or sanitized sample files while developing parsers, and preserve the reference implementation's local-only design for routine use.
