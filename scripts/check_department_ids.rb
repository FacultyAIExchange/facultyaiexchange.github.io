#!/usr/bin/env ruby
# frozen_string_literal: true

# Validate department_id front matter across _examples/*.md.
#
# The homepage department tally counts unique department_id values, so the
# likely contributor mistakes this guards against are:
#   - a missing or empty department_id (the Pages build would fail later,
#     with a less helpful message)
#   - an ID that isn't lowercase kebab-case (utk_physics, "UTK Physics", ...)
#   - an ID that doesn't encode BOTH a university and a department
#     (physics-and-astronomy, utk): too few parts, every part a generic
#     discipline word, or the ID matching only the department-name or only
#     the institution portion of the department field
#   - two spellings of the same department splitting the tally:
#       * the same department name mapped to different IDs
#       * IDs that differ only by an added prefix/suffix token
#         (physics-and-astronomy vs utk-physics-and-astronomy)
#       * IDs within a small edit distance of each other (likely typos)
#
# Errors fail the run; warnings are printed as GitHub annotations but pass.
# Output uses GitHub workflow commands so problems show up inline on PRs.

require "pathname"
require "set"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
FRONT_MATTER = /\A---\s*\n(.*?)\n---\s*(?:\n|\z)/m
ID_FORMAT = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

# Words that name disciplines, academic units, or connectors rather than a
# specific university. An ID made up entirely of these (physics-and-astronomy,
# computer-science) almost certainly forgot the university part. Includes the
# placeholder words from docs/example-template.md so an unedited copy fails
# with a helpful message.
GENERIC_ID_WORDS = %w[
  a an and communications for in of or the to your
  department dept division faculty program school studies unit
  center centre college institute laboratory university
  accounting aerospace agriculture anthropology archaeology architecture art
  arts astronomy astrophysics atmospheric biochemistry biology biomedical
  biophysics botany business cellular chemical chemistry civil classics
  communication computer computing criminology dance data dentistry design
  ecology economics education electrical engineering english environmental
  film finance forestry genetics geography geology geosciences government
  health history humanities industrial informatics information journalism
  kinesiology languages law library linguistics literature management marine
  marketing materials math mathematics mechanical media medical medicine
  microbiology molecular music neuroscience nursing oceanography pharmacy
  philosophy physics physiology planning policy political politics psychology
  public religion science sciences social sociology software statistics
  systems theater theatre theology veterinary work zoology
].to_set.freeze

$errors = 0

def rel(path)
  Pathname.new(path).relative_path_from(ROOT)
end

def error(path, message)
  $errors += 1
  puts "::error file=#{rel(path)}::#{message}"
end

def warning(path, message)
  puts "::warning file=#{rel(path)}::#{message}"
end

def front_matter(path)
  source = File.read(path, encoding: "UTF-8")
  match = FRONT_MATTER.match(source)
  unless match
    error(path, "Missing YAML front matter (the file must start with a --- block).")
    return nil
  end
  YAML.safe_load(match[1], aliases: false) || {}
rescue Psych::SyntaxError => e
  error(path, "Invalid YAML front matter: #{e.message}")
  nil
end

# "Physics & Astronomy, University of Tennessee" and
# "physics and astronomy - university of tennessee" normalize the same way.
def normalize_department(name)
  name.to_s.downcase.gsub("&", " and ").gsub(/[^a-z0-9]+/, " ").strip.squeeze(" ")
end

def levenshtein(a, b)
  return b.length if a.empty?
  return a.length if b.empty?

  prev = (0..b.length).to_a
  a.each_char.with_index(1) do |ca, i|
    row = [i]
    b.each_char.with_index(1) do |cb, j|
      row << [prev[j] + 1, row[j - 1] + 1, prev[j - 1] + (ca == cb ? 0 : 1)].min
    end
    prev = row
  end
  prev.last
end

def slugify(text)
  normalize_department(text).tr(" ", "-")
end

# Every ID must encode both a university and a department
# (utk-physics-and-astronomy = utk + physics-and-astronomy). CI can't know
# every university's abbreviation, so this catches the likely shapes of a
# half-encoded ID. The department field ("Physics & Astronomy, University of
# Tennessee, Knoxville") is only consulted for single-ID files, where it
# describes exactly that ID.
def check_encodes_university_and_department(path, id, department)
  tokens = id.split("-")
  if tokens.length < 2
    error(path, "department_id \"#{id}\" must encode both a university and a department, " \
                "e.g. utk-physics-and-astronomy.")
    return
  end

  if tokens.all? { |token| GENERIC_ID_WORDS.include?(token) }
    error(path, "department_id \"#{id}\" doesn't appear to include a university — every part is a " \
                "generic department word. Prefix your university's abbreviation " \
                "(e.g. utk-#{id}).")
    return
  end

  return if department.nil? || department.empty?

  name_part, _, institution_part = department.partition(",")
  if slugify(name_part) == id
    error(path, "department_id \"#{id}\" is just the department name with no university encoded. " \
                "Prefix your university's abbreviation (e.g. utk-#{id}).")
    return
  end

  segments = institution_part.split(",")
  institution_slugs = (segments + [institution_part]).map { |s| slugify(s) }.reject(&:empty?)
  if institution_slugs.include?(id)
    error(path, "department_id \"#{id}\" encodes only the university with no department. " \
                "Append the department (e.g. #{id}-#{slugify(name_part)}, or a shorter " \
                "university abbreviation plus the department).")
  end
end

# One ID extending the other by whole hyphen-separated tokens
# (physics-and-astronomy vs utk-physics-and-astronomy) is the classic
# "same department, inconsistent prefix" split.
def token_extension?(a, b)
  short, long = [a, b].sort_by(&:length)
  return false if short == long

  long.start_with?("#{short}-") || long.end_with?("-#{short}") ||
    long.split("-").each_cons(short.split("-").length).any? { |slice| slice.join("-") == short }
end

# id => { files:, departments: }
usages = Hash.new { |hash, key| hash[key] = { files: [], departments: [] } }

example_files = Dir[ROOT.join("_examples", "*.{md,markdown}")].sort
puts "Checking #{example_files.length} example file(s) in _examples/"

example_files.each do |path|
  metadata = front_matter(path)
  next if metadata.nil?

  department = metadata["department"].to_s.strip
  if department.empty?
    error(path, "Missing the department field (the human-readable department name).")
  end

  raw = metadata.key?("department_ids") ? metadata["department_ids"] : metadata["department_id"]
  ids = Array(raw).map { |value| value.to_s.strip }.reject(&:empty?)
  if ids.empty?
    error(path, "Missing department_id. Add a stable lowercase ID (e.g. utk-physics-and-astronomy) " \
                "and reuse the exact same value as other examples from this department.")
    next
  end

  ids.each do |id|
    if ID_FORMAT.match?(id)
      check_encodes_university_and_department(path, id, ids.length == 1 ? department : nil)
    else
      error(path, "department_id \"#{id}\" must be lowercase kebab-case: letters, digits, and single " \
                  "hyphens only (e.g. utk-physics-and-astronomy).")
    end
    usage = usages[id.downcase]
    usage[:files] << rel(path).to_s
    # Only a single-ID file ties its department name to the ID; a
    # department_ids list is a multi-department collaboration, where the
    # combined department field doesn't describe any one ID.
    usage[:departments] << department if ids.length == 1 && !department.empty?
  end
end

# Same department name mapped to more than one ID splits the tally.
by_department = Hash.new { |hash, key| hash[key] = {} }
usages.each do |id, usage|
  usage[:departments].each do |department|
    (by_department[normalize_department(department)][id] ||= []).concat(usage[:files])
  end
end
by_department.each do |_normalized, ids|
  next if ids.length < 2

  detail = ids.map { |id, files| "\"#{id}\" (#{files.uniq.join(", ")})" }.join(" vs ")
  error(ROOT.join("_examples"),
        "The same department is listed under different department_id values: #{detail}. " \
        "Pick one ID and use it in every example from that department.")
end

# Distinct IDs that look like the same department: token extensions or typos.
ids = usages.keys.sort
ids.combination(2) do |a, b|
  next unless token_extension?(a, b) || levenshtein(a, b) <= 2

  files = (usages[a][:files] + usages[b][:files]).uniq.join(", ")
  error(ROOT.join("_examples"),
        "department_id values \"#{a}\" and \"#{b}\" look like the same department spelled two ways " \
        "(#{files}). Each spelling counts as a separate department in the homepage tally — if they " \
        "are the same department, use one ID everywhere; if they are genuinely different, rename one " \
        "so they are clearly distinct.")
end

# Same ID under visibly different department names is usually fine (rewording),
# but worth a look — it could be two departments colliding on one ID.
usages.each do |id, usage|
  names = usage[:departments].uniq { |name| normalize_department(name) }
  next if names.length < 2

  warning(ROOT.join("_examples"),
          "department_id \"#{id}\" is used with different department names: " \
          "#{names.map(&:inspect).join(" vs ")} (#{usage[:files].uniq.join(", ")}). " \
          "If these are different departments, give them different IDs.")
end

if $errors.zero?
  puts "OK: #{usages.length} unique department_id value(s), no problems found."
else
  puts "Found #{$errors} problem(s)."
  exit 1
end
