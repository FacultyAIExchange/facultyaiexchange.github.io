---
layout: page
title: Contribute
permalink: /contribute/
---

# Add a gallery example

To add an account of faculty AI practice to the AI Usage Gallery, create a new Markdown file in `_examples`. Start from `docs/example-template.md`, keep the relevant front matter fields, and write the details in ordinary Markdown below the front matter.

Each example should explain:

- what faculty used the AI application for;
- what made it useful in practice;
- what materials another person would need to adapt it;
- which skill files, prompts, or examples are relevant.

Related skill files can be stored under `skills/your-skill-name/SKILL.md` and linked from the example's `skill_files` list.

When an example has a source repository, add its URL as `repository_url`. When it has a related skill, add one or more entries to `skill_files` using a local `path` or an external `url`. The gallery card and detail page will show these links automatically; omit either field when it does not apply.

# Add a faculty resource

To add a reusable faculty-facing resource, create a new Markdown file in `_resources`. Start from `docs/resource-template.md`, keep the front matter fields, and write the resource in ordinary Markdown below the front matter.

Resources are for reusable materials such as syllabus text, assignment guidance, research group norms, checklists, and short faculty-facing guides.
