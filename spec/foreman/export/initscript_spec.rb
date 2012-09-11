require "spec_helper"
require "foreman/engine"
require "foreman/export/initscript"
require "tmpdir"

describe Foreman::Export::Initscript, :fakefs do
  let(:procfile) { FileUtils.mkdir_p("/tmp/app"); write_procfile("/tmp/app/Procfile") }
  let(:formation) { nil }
  let(:engine)    { Foreman::Engine.new(:formation => formation).load_procfile(procfile) }
  let(:options)   { Hash.new }
  let(:initscript) { FileUtils.mkdir_p("/tmp/init"); Foreman::Export::Initscript.new("/tmp/init", engine, options) }

  before(:each) { load_export_templates_into_fakefs("initscript") }
  before(:each) { stub(initscript).say }

  it "exports to the filesystem" do
    initscript.export
    normalize_space(File.read("/tmp/init/app")).should == normalize_space(example_export_file("initscript/app"))
  end

  context  "with concurrency" do
    let(:options) { Hash[:concurrency => "alpha=2"] }

    it "exports to the filesystem with concurrency" do
      initscript.export
      normalize_space(File.read("/tmp/init/app")).should == normalize_space(example_export_file("initscript/app-concurrency"))
    end
  end

end
