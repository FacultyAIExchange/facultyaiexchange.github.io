# Faculty AI Gallery

A GitHub Pages site for sharing generative AI applications that faculty have found useful.

## Why Jekyll

This first version uses Jekyll because GitHub Pages can build it directly and contributors only need to add Markdown files. Hugo with Blowfish would also work, but it would require a custom build workflow and a larger theme setup. Jekyll keeps the first shared editing workflow simpler.

## Add a gallery item

1. Copy `docs/gallery-item-template.md` into `_apps/your-item-name.md`.
2. Edit the front matter at the top of the file.
3. Write the item details in Markdown below the front matter.
4. Add related skill files under `skills/your-skill-name/SKILL.md`.
5. Link those files from the item's `skill_files` list.

Each Markdown file in `_apps` becomes a gallery detail page.

## Run locally

If you have Ruby 3 and Bundler available:

```sh
bundle install
bundle exec jekyll serve
```

The GitHub Pages workflow builds the site from `main` whenever changes are pushed.

## Publish on GitHub Pages

In the repository settings, open **Pages** and set the build source to **GitHub Actions**. The included workflow will build and deploy the site.
