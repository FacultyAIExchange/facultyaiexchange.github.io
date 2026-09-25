---
title: A Self-Hosted Database for Mid-Size Collaborations
summary: A membership, speakers, publications, and author-list database developed for the US Muon Collider Collaboration, which has around 300 members. Straightforward for another scientific collaboration to adapt and deploy themselves.
faculty: Dr. Tova Holmes
department: Physics & Astronomy, University of Tennessee, Knoxville
department_id: utk-physics-and-astronomy
audience: Leadership of mid-sized to large research collaborations
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

Collaborations databases have proved essential for the success of the largest collaborations, like the ATLAS and CMS Experiments at CERN. They run custom software built on Glance/Fence to track who is a member, what talks they've given, what papers they've worked on, and how they're contributing to the collaboration. This hasn't been accessible for mid-size collaborations due to the complexity of building and maintaining them, but agentic AI is making that work much, much simpler. 

This repo contains a lightweight collaboration database built for the US Muon Collider Collaboration, which has around 300 members. It allows members to update their statuses and emails as they change positions, and has easy exports to update listserv membership. It helps the leadership keep track of who is working in which areas, and keeps track of how talks have been distributed. It can assist in creating author lists, and the corresponding grant acknowledgements. Login is via ORCID ID, so there's no extra account management to take care of.

Everything is interconnected, so it's easy to go from institute to person to talks seamlessly. 

## Why it was useful

Membership records are required for voting role and mailing lists, but also useful for thinking about equitable distribution of talks and streamlining creation of author lists. 

In small ways, it also helps with tone setting in the collaboration. We have the option for people to request internal review on papers, and we assign members to look them over and give feedback. Now this labor is tracked in the database, and an acknowledgements paragraph is generated with thanks to those reviewers, in addition to funding agency information from the authors of the paper.

The design deliberately avoids anything a small collaboration cannot sustain. It runs from one `docker compose` command on any Linux box, uses ORCID's free public API for sign-in so there are no passwords to manage for members, needs only an SMTP relay for notifications, and keeps member data entirely on the collaboration's own server. Importers take the existing registration-form spreadsheets so a new instance is populated in an afternoon, and institution details (coordinates, short names, author-list addresses) are filled automatically from the Research Organization Registry.

Claude Code wrote nearly all of the implementation. I set the requirements and design decisions up front — which modules to include, the authentication model, the technology stack, the deployment pattern — and the initial plan was drafted from those and iterated through several rounds of questions before any code was written. Since then, development has run through GitHub issues: users report what they want changed or what is broken, and an agent works the issue on a branch, runs the test suite against a real database, and opens a pull request for me to review.

## Materials to adapt

- The [USMCCDB repository](https://github.com/trholmes/USMCCDB), which includes a README walking through deployment
- You'll need a Linux server with Docker or Podman, a domain name, and ideally SMTP capabilities (if you want emails to be generated)
- There are human readable planning documents in the repo that can be edited in a fork and handed to an agent for your own specific implementation:`docs/ROLES.md`, `docs/PLAN.md`, and `docs/NOTIFICATIONS.md`
