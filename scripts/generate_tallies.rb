#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
FRONT_MATTER = /\A---\s*\n(.*?)\n---\s*(?:\n|\z)/m

def collection_files(name)
  Dir[ROOT.join("_#{name}", "*.{md,markdown}")].sort
end

def front_matter(path)
  source = File.read(path)
  match = FRONT_MATTER.match(source)
  raise "#{path} is missing YAML front matter" unless match

  YAML.safe_load(match[1], aliases: false) || {}
rescue Psych::SyntaxError => error
  raise "#{path} has invalid YAML front matter: #{error.message}"
end

examples = collection_files("examples")
resources = collection_files("resources")

department_ids = examples.flat_map do |path|
  metadata = front_matter(path)
  value = metadata["department_ids"] || metadata["department_id"]
  raise "#{path} must define department_id (or department_ids)" if value.nil?

  Array(value)
end

department_ids.map! { |value| value.to_s.strip.downcase }
if department_ids.any?(&:empty?)
  raise "department_id values must not be empty"
end

tallies = {
  "examples" => examples.length,
  "resources" => resources.length,
  "departments" => department_ids.uniq.length
}

destination = ROOT.join("_data", "tallies.yml")
FileUtils.mkdir_p(destination.dirname)
File.write(destination, tallies.to_yaml)

puts "Generated homepage tallies: #{tallies.map { |key, value| "#{key}=#{value}" }.join(", ")}"
