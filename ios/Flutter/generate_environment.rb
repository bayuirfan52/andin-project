#!/usr/bin/env ruby

source_root = ARGV.fetch(0)
environment_name = File.read(File.join(source_root, ".envfile")).strip
unless [".env.staging", ".env.production"].include?(environment_name)
  abort("Unsupported environment file: #{environment_name}")
end

environment_path = File.expand_path("../#{environment_name}", source_root)
values = {}
File.foreach(environment_path) do |line|
  entry = line.strip
  next if entry.empty? || entry.start_with?("#")

  key, value = entry.split("=", 2)
  abort("Invalid entry in #{environment_name}") unless value

  value = value.strip
  if value.length >= 2 &&
      ((value.start_with?('"') && value.end_with?('"')) ||
       (value.start_with?("'") && value.end_with?("'")))
    value = value[1...-1]
  end
  values[key.strip] = value
end

%w[APP_ID APP_NAME APP_SUFFIX_ID FLAVOR].each do |key|
  abort("Missing #{key} in #{environment_name}") unless values.key?(key)
end

values["APP_FLAVOR"] = values["FLAVOR"]
output = values.slice("APP_ID", "APP_NAME", "APP_SUFFIX_ID", "FLAVOR", "APP_FLAVOR")
File.write(
  File.join(source_root, "Flutter/tmp.xcconfig"),
  output.map { |key, value| "#{key} = #{value}" }.join("\n") + "\n"
)
