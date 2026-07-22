---
title: DOCENT — Outreach & Community Engagement Tracker
summary: A self-hosted web app that helps a scientific community log outreach visits, visualize coverage on a map, and share resources.
faculty: Prof. Lawrence Lee
department: Physics & Astronomy, University of Tennessee, Knoxville
audience: Departments and institutions tracking community engagement
use_case: Outreach tracking, grant reporting
tools:
  - Docker
  - FastAPI
  - PostgreSQL
  - React
tags:
  - Research
  - Outreach
  - Grant reporting
image: /assets/images/outreach-tracker-docent.png
repository_url: https://github.com/lawrenceleejr/DOCENT
---

## What faculty used it for

DOCENT (Distributed Outreach & Community Engagement Network Tracker) lets a research community log every outreach visit — to grade schools, community colleges, museums, libraries, pubs, and beyond — in one shared record. Researchers register accounts and record each event's venue, date, host, audience, attendance, and notes. The app provides a live analysis dashboard, a coverage map showing which nearby institutions have been reached (and which are gaps), and a reports tab that exports grant-ready summaries of collective Broad Impact over any date range as PDF, CSV, Markdown, or JSON.

## Why it was useful

Keeping track of outreach across an entire research group is tedious and error-prone. DOCENT solves this by giving every member a shared platform to log visits and immediately see how the community's engagement is growing. The map view highlights coverage gaps, helping target future outreach. When reporting season arrives, exporting a polished summary is a single click instead of weeks of spreadsheet archaeology.

The tool can run entirely on the community's own server — no third-party cloud, no vendor with a copy of your records — making it straightforward to satisfy campus data-governance and FERPA obligations for any student-related information.

Claude was used for the implementation of the all-human-designed features, including the deployment model, cross-instance data-sharing, and the privacy model. 