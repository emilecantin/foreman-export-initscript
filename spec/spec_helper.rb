require "rspec"
require "fakefs/safe"
require "fakefs/spec_helpers"

require 'foreman-export-initscript'

def resource_path(filename)
  File.expand_path("../resources/#{filename}", __FILE__)
end

def write_procfile(procfile="Procfile", alpha_env="")
  File.open(procfile, "w") do |file|
    file.puts "alpha: ./alpha" + " #{alpha_env}".rstrip
    file.puts "\n"
    file.puts "bravo:\t./bravo"
  end
  File.expand_path(procfile)
end

def load_export_templates_into_fakefs(type)
  FakeFS.deactivate!
  files = Dir[File.expand_path("../../data/export/#{type}/**", __FILE__)].inject({}) do |hash, file|
    hash.update(file => File.read(file))
  end
  FakeFS.activate!
  files.each do |filename, contents|
    #require "debug"
    FileUtils.mkdir_p RealFile.dirname filename
    File.open(filename, "w") do |f|
      f.puts contents
    end
  end
end

def example_export_file(filename)
  FakeFS.deactivate!
  data = File.read(File.expand_path(resource_path("export/#{filename}"), __FILE__))
  FakeFS.activate!
  data
end

def normalize_space(s)
  s.gsub(/\n[\n\s]*/, "\n")
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.color_enabled = true
  config.order = 'rand'
  config.include FakeFS::SpecHelpers, :fakefs
  config.mock_with :rr
end
