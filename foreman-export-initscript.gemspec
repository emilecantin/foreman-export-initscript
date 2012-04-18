# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman-export-initscript"
  s.version     = "0.0.1"
  s.authors     = ["Emile Cantin"]
  s.email       = ["emile.cantin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Export foreman Procfile to a init script}
  s.description = %q{Export foreman Procfile to a init script}

  s.rubyforge_project = "foreman-export-initscript"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_development_dependency "fakefs", git: "git://github.com/defunkt/fakefs.git"
  s.add_development_dependency "rr"
  s.add_dependency "foreman"
  # s.add_runtime_dependency "rest-client"
end
