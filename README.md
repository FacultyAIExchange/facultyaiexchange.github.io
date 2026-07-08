# Faculty AI Exchange

A GitHub Pages site for faculty sharing practical experience and reusable resources for incorporating generative AI into teaching, research, mentoring, and academic work ethically and responsibly.

Canonical site URL: <https://facultyaiexchange.github.io/>

## Why Jekyll

This first version uses Jekyll because GitHub Pages can build it directly and contributors only need to add Markdown files. Hugo with Blowfish would also work, but it would require a custom build workflow and a larger theme setup. Jekyll keeps the first shared editing workflow simpler.

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

## Run locally

If you have Ruby 3 and Bundler available:

```sh
bundle install
bundle exec jekyll serve
```

GitHub Pages can build the site from `main` whenever changes are pushed.

## Publish on GitHub Pages

In the repository settings, open **Pages** and choose:

- **Source:** Deploy from a branch
- **Branch:** `main`
- **Folder:** `/ (root)`

GitHub Pages will run its Jekyll build whenever changes are pushed to `main`.

## Repository

This is an organization GitHub Pages site. The repository is named `facultyaiexchange.github.io`, so GitHub Pages publishes it at the root URL for the `facultyaiexchange` organization.
