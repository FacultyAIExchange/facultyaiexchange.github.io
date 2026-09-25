---
title: USMCCDB — A Self-Hosted Collaboration Database
summary: A membership, speakers, publications, and author-list database for the US Muon Collider Collaboration, built as an open-source stack that any scientific collaboration can deploy on its own server.
faculty: Dr. Tova Holmes
department: Physics & Astronomy, University of Tennessee, Knoxville
department_id: utk-physics-and-astronomy
audience: Scientific collaborations and research communities that need to manage membership, speakers, and publications
use_case: Research administration, collaboration management
tools:
  - Docker
  - FastAPI
  - PostgreSQL
  - React
  - ORCID
  - Claude
tags:
  - Research
  - Collaboration management
  - Publications
  - Automation
image: /assets/images/usmcc-collaboration-database.png
repository_url: https://github.com/trholmes/USMCCDB
---

## What faculty used it for

Large physics collaborations at CERN run on bespoke database systems (Glance/Fence) that track who is a member, who has given which talks, which papers are in progress, and who belongs on the author list of each one. Smaller collaborations do the same bookkeeping in spreadsheets, Google Forms, and email — and it shows. The US Muon Collider Collaboration needed the former without the CERN infrastructure the real systems are welded to, so we built a Fence-inspired version from scratch.

The result is a single web application covering four things a collaboration has to get right:

- **Membership** — people, institutions, dated affiliations, career stage, working groups, and leadership roles, with a register → approve workflow and an append-only audit trail. Members sign in with their ORCID iD; the office reviews new registrations.
- **Speakers bureau** — conferences and talk records, member nominations, office assignment of speakers, and fair-share statistics per person and institution so talk opportunities are distributed visibly and equitably.
- **Publications** — a registry of papers, proceedings, and notes with a status workflow from *in progress* through *collaboration review* to *published*, contact people, reviewers, and auto-assigned collaboration document codes.
- **Author lists** — one click builds the alphabetical, accent-aware author list for any cutoff date, from either the whole collaboration's authorship periods or just the people involved in a paper, frozen as a snapshot and exported as plain text, LaTeX, or the `authors.xml` format INSPIRE and arXiv accept.

Everything cross-links the way the CERN systems do: a directory row leads to an institution page, which leads to member profiles, which lead to that person's talks and papers. Institutions plot on a map weighted by member count. A built-in admin panel handles accounts, a site announcement banner, sign-in auditing, and nightly backups with one-click restore, so the collaboration runs it without a dedicated sysadmin.

## Why it was useful

A collaboration's membership records are its institutional memory, and they are also the input to things that carry real consequences: who is eligible to vote, whose name appears on a paper and under which institution, who has and hasn't been given a plenary talk. Keeping that in spreadsheets means every author list is assembled by hand under deadline pressure, every nomination is an email thread, and the history of how a decision was reached is lost. Putting it in one system with dated affiliations and an audit trail means the author list for a paper submitted next month is just a query, and the fair-share statistics for the speakers committee are computed rather than argued.

The design deliberately avoids anything a small collaboration cannot sustain. It runs from one `docker compose` command on any Linux box, uses ORCID's free public API for sign-in so there are no passwords to manage for members, needs only an SMTP relay for notifications, and keeps member data entirely on the collaboration's own server. Importers take the existing registration-form spreadsheets so a new instance is populated in an afternoon, and institution details (coordinates, short names, author-list addresses) are filled automatically from the Research Organization Registry.

Claude Code wrote nearly all of the implementation. I set the requirements and design decisions up front — which modules to include, the authentication model, the technology stack, the deployment pattern — and the initial plan was drafted from those and iterated through several rounds of questions before any code was written. Since then, development has run through GitHub issues: I file what I want changed or what is broken, and an AI session works the issue on a branch, runs the test suite against a real database, and opens a pull request for me to review. A `CLAUDE.md` file in the repository records the project's conventions and invariants (inclusive date ranges, at most one open primary affiliation per person, how roles grant permissions), which keeps each new session consistent with the last. The permission rules, the author-list generation logic, and the email notification catalogue were all specified by hand and are documented alongside the code.

## Materials to adapt

- The [USMCCDB repository](https://github.com/trholmes/USMCCDB), which includes the full stack, a `seed-demo` command that populates a fictional collaboration for evaluation, and a README walking through deployment, ORCID setup, email, and importing existing records.
- A Linux server with Docker or Podman; optionally a domain name (the bundled Caddy container obtains HTTPS certificates automatically) and an institutional SMTP relay.
- The collaboration-specific parts are the role names, the publication status workflow, the document-code format, and the author-list export formats. All are documented in `docs/ROLES.md`, `docs/PLAN.md`, and `docs/NOTIFICATIONS.md`, and the `CLAUDE.md` conventions file is written so an AI coding assistant can be asked to rework them for another collaboration. Do the adaptation against the demo dataset rather than real member records.
