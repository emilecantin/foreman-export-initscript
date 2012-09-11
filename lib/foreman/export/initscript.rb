require "erb"
require "foreman/export"

class Foreman::Export::Initscript < Foreman::Export::Base

  def export

    super

    Dir["#{location}/#{app}"].each do |file|
      say "cleaning up: #{file}"
      clean file
    end

    write_template "initscript/master.erb", "#{app}", binding
   end

end

