#!/usr/bin/env bash
# Map source files changed since <base-ref> to the built pages they produce.
#
# Usage: scripts/pr_changed_pages.sh <base-ref>
#
# Must run from the repo root after the site has been built into _site/.
# Prints one line per affected page, tab-separated:
#   <status>\t<url-path>\t<slug>
# where <status> is the git diff status letter (A = added, M = modified, ...),
# <url-path> is the page path relative to the site root (empty = homepage),
# and <slug> is a filesystem-safe name for the screenshot file.
set -euo pipefail

base="${1:?usage: pr_changed_pages.sh <base-ref>}"

declare -A seen=()
sitewide=0

emit() {
  local status="$1" url="$2" slug
  [[ -n "${seen[k$url]:-}" ]] && return 0
  seen[k$url]=1
  slug=$(printf '%s' "$url" | sed 's#/$##; s#[^A-Za-z0-9._-]#-#g')
  [[ -z "$slug" ]] && slug=home
  printf '%s\t%s\t%s\n' "$status" "$url" "$slug"
}

site_has() { [[ -f "_site/$1" ]]; }

while IFS=$'\t' read -r status f1 f2; do
  file="$f1"
  case "$status" in
    D*) continue ;;
    R* | C*) file="$f2" ;;
  esac
  status="${status:0:1}"

  case "$file" in
    _examples/*.md)
      name=$(basename "$file" .md)
      site_has "examples/$name/index.html" && emit "$status" "examples/$name/"
      ;;
    _resources/*.md)
      name=$(basename "$file" .md)
      site_has "resources/$name/index.html" && emit "$status" "resources/$name/"
      ;;
    index.md | index.html)
      emit "$status" ""
      ;;
    *.md)
      # Top-level standalone pages: honor a permalink in the front matter,
      # otherwise try Jekyll's default output locations. Files that are
      # excluded from the build (docs/, skills/, ...) match nothing in _site
      # and are skipped naturally.
      name=$(basename "$file" .md)
      perma=$(awk 'NR > 1 && /^---/ { exit } sub(/^permalink:[[:space:]]*/, "") { print; exit }' "$file" | tr -d '"' | sed 's#^/##')
      if [[ -n "$perma" ]] && site_has "${perma%/}/index.html"; then
        emit "$status" "${perma%/}/"
      elif site_has "$name/index.html"; then
        emit "$status" "$name/"
      elif site_has "$name.html"; then
        emit "$status" "$name.html"
      fi
      ;;
    _layouts/* | _includes/* | assets/* | _config.yml | scripts/generate_tallies.rb)
      sitewide=1
      ;;
  esac
done < <(git diff --name-status "$base"...HEAD)

# When only site-wide files changed (layouts, includes, styles, config),
# no single page maps to the diff — show the homepage as a representative page.
if [[ $sitewide -eq 1 && ${#seen[@]} -eq 0 ]]; then
  emit M ""
fi
