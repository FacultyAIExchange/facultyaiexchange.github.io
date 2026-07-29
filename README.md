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

## If you'd like to test out a contribution, you can run locally

If you have Ruby 3 and Bundler available:

```sh
bundle install
bundle exec jekyll serve
```

GitHub Pages can build the site from `main` whenever changes are pushed.

The Pages workflow runs `scripts/generate_tallies.rb` before each build. It counts gallery examples, resources, and unique `department_id` values into an ephemeral `_data/tallies.yml`, which supplies the three homepage tallies without committing generated data.
