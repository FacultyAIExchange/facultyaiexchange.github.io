---
title: Local Grant Budget Dashboard for PIs
summary: A local-only dashboard that turns institutional finance exports into grant projections, spending alerts, and hiring scenarios without sending sensitive data off the faculty member's computer.
faculty: Dr. Tova Holmes
department: Physics & Astronomy, University of Tennessee, Knoxville
audience: Principal investigators
use_case: Research administration
tools:
  - Python
  - JavaScript
  - Institutional CSV exports
  - skill for using an LLM to adapt to your institution
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

This tool makes it possible to visualize and project all of your grants in one place. You can see your past spending categories and make changes to see their impact on your spend down. It also creates alerts when spending goes too far astray from your budgets. 

Its People table supports forward planning that the institutional reports do not provide. It can model a new hire, a student's expected graduation, a change in salary, or a person's support split across grants. Those edits flow into projections that account for salary, fringe, tuition and fees, and each award's facilities and administrative cost rate.

The tool runs locally to keep all data fully private. It makes no outbound network requests, and keeps data files out of version control. AI was used to help build the tool, but the financial analysis itself uses transparent, deterministic formulas and does not send institutional data to an AI service.

## Why it was useful

Creating this tool made me actually feel like I understood my budget for the first time. It was not only easy to see where I was at, but easy to understand how taking on a new student would impact my finances. It is making a real change in how informed my financial choices are as a PI.

Its practical utility is limited only by the ease (or lack thereof) of exporting information from your University's system. You can drop in fresh exports and immediately see the changes. 

The accompanying skill file turns the project into a reusable method: it asks an AI coding assistant to inventory local exports, validate their quirks and totals, learn institution-specific rules, and then adapt the reference implementation. You can do this step with dummy data based on your institution's formats to prevent any data being sent to an LLM.

## Materials to adapt

- The [UTKGrantDashboard repository](https://github.com/trholmes/UTKGrantDashboard), which includes fictional demo data and a reference implementation. Look at the README for details on what it takes in.
- This package includes a skill file (also linked below) that can help guide an AI agent to re-work the package for your institution.
