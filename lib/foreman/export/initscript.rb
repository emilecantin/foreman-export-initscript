require "erb"
require "foreman/export"

class Foreman::Export::Initscript < Foreman::Export::Base

  def export
    error("Must specify a location") unless location

    FileUtils.mkdir_p location

    app = self.app || File.basename(engine.directory)
    user = self.user || app
    log_root = self.log || "/var/log/#{app}"
    template_root = Pathname.new(File.dirname(__FILE__)).join('..', '..', '..', 'data', 'export', 'initscript').expand_path

    Dir["#{location}/#{app}"].each do |file|
      say "cleaning up: #{file}"
      FileUtils.rm(file)
    end

    master_template = export_template("initscript", "master.erb", template_root)
    master_config   = ERB.new(master_template).result(binding)
    write_file "#{location}/#{app}", master_config

   end

end

