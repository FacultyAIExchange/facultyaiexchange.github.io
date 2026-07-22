---
title: DOCENT — Outreach & Community Engagement Tracker
summary: A self-hosted web app that helps a scientific community log outreach visits, visualize coverage on a map, and export grant-ready Broad Impact reports at the click of a button.
faculty: Prof. Lawrence Lee Jr.
department: Physics & Astronomy, University of Tennessee, Knoxville
audience: Research groups and departments tracking community engagement
use_case: Outreach tracking and grant reporting
tools:
  - Docker
  - FastAPI
  - PostgreSQL
  - React
  - GitHub Copilot
tags:
  - Research
  - Outreach
  - Broad Impact
  - Grant reporting
  - Data privacy
image: /assets/images/outreach-tracker-docent.svg
repository_url: https://github.com/lawrenceleejr/DOCENT
---

## What faculty used it for

DOCENT (Distributed Outreach & Community Engagement Network Tracker) lets a research community log every outreach visit — to grade schools, community colleges, museums, libraries, and beyond — in one shared record. Researchers register accounts and record each event's venue, date, host, audience, attendance, and notes. The app provides a live analysis dashboard, a coverage map showing which nearby institutions have been reached (and which are gaps), and a reports tab that exports grant-ready summaries of collective Broad Impact over any date range as PDF, CSV, Markdown, or JSON.

## Why it was useful

Grant agencies increasingly require documentation of Broad Impact, but keeping track of outreach across an entire research group is tedious and error-prone. DOCENT solves this by giving every member a shared platform to log visits and immediately see how the community's engagement is growing. The map view highlights coverage gaps, helping target future outreach. When reporting season arrives, exporting a polished summary is a single click instead of weeks of spreadsheet archaeology.

The tool runs entirely on the group's own server — no third-party cloud, no vendor with a copy of your records — making it straightforward to satisfy campus data-governance and FERPA obligations for any student-related information.

AI (GitHub Copilot) was used heavily in developing the tool itself, but the deployed application uses no AI services — it is a deterministic web application that keeps all data local.

## Materials to adapt

- The [DOCENT repository](https://github.com/lawrenceleejr/DOCENT), which includes a one-command Docker Compose deployment (`./scripts/start.sh`).
- An admin panel that generates ready-to-send emails for requesting a subdomain from university IT.
- Institution import via OpenStreetMap: enter an address and radius to bulk-import nearby schools and community organizations.
- Free cloud hosting options documented for groups without a spare machine.
