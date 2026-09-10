# Faculty AI Exchange

A GitHub Pages site for faculty sharing practical experience and reusable resources for incorporating generative AI into teaching, research, mentoring, and academic work ethically and responsibly.

Site URL: <https://facultyaiexchange.org/>

## Structure

This repo uses Jekyll to build a static webpage from Markdown files. Contributing material to the site only required committing new Markdown files with the text of the project card, and if needed, an associated skill. 

## Add a gallery example

1. Copy `docs/example-template.md` into `_examples/your-example-name.md`.
2. Edit the front matter at the top of the file.
3. Write the example details in Markdown below the front matter.
4. Add related skill files under `skills/your-skill-name/SKILL.md`.
5. Link those files from the example's `skill_files` list.

Each Markdown file in `_examples` appears on the AI Usage Gallery page and becomes an example detail page.

## Add a faculty resource

1. Copy `docs/resource-template.md` into `_resources/your-resource-name.md`.
2. Edit the front matter at the top of the file.
3. Write the resource content in Markdown below the front matter.

Each Markdown file in `_resources` becomes a resource detail page and appears on the resources page.

## Pull request page previews

Every pull request runs the `PR page screenshots` workflow (`.github/workflows/pr-screenshots.yml`). It builds the site, maps the PR's changed files to the pages they produce (`scripts/pr_changed_pages.sh`), screenshots each one, and posts the images in a single auto-updating PR comment — so reviewers can see the rendered pages without checking out the branch. If only site-wide files change (layouts, includes, styles), it screenshots the homepage as a representative page.

The images are committed to the dedicated `pr-screenshots` branch, which exists only to host them and is never merged. Pull requests from forks have a read-only token, so those runs skip the comment and instead upload the screenshots as a downloadable workflow artifact named `pr-page-screenshots`.

## If you'd like to test out a contribution, you can run locally

If you have Ruby 3 and Bundler available:

```sh
bundle install
bundle exec jekyll serve
```

GitHub Pages can build the site from `main` whenever changes are pushed.

The Pages workflow runs `scripts/generate_tallies.rb` before each build. It counts gallery examples, resources, and unique `department_id` values into an ephemeral `_data/tallies.yml`, which supplies the three homepage tallies without committing generated data.

Because that tally counts unique `department_id` values, the `Department ID check` workflow (`.github/workflows/department-id-check.yml`) runs `scripts/check_department_ids.rb` on every pull request. It fails with inline annotations when an example is missing `department_id` or `department`, when an ID isn't lowercase kebab-case, when an ID doesn't appear to encode both a university and a department (a single word, only generic discipline words like `computer-science`, or an ID matching just the department-name or just the institution portion of the `department` field), or when two IDs look like the same department spelled different ways (same department name under different IDs, one ID extending the other such as `physics-and-astronomy` vs `utk-physics-and-astronomy`, or IDs within a small edit distance of each other). It can be run locally with `ruby scripts/check_department_ids.rb`.
