require 'spec_helper'

RSpec.describe Prow::Paths do
  let(:paths) { Prow::Paths.new }
  let(:source_path)   { `pwd`.chomp }

  context 'when initialized with no paths' do
    it "uses pwd for the source directory" do
      expect(paths.source).to eq(`pwd`.chomp)
    end

    it "uses public in pwd in the compile directory" do
      expect(paths.compile).to eq(paths.source + "/public")
    end
  end

  context 'when initialized with a source path' do
    let(:source_path) { File.dirname(__FILE__) + "/support" }
    let(:paths) { Prow::Paths.new(source_path) }

    it "uses that for the source_directory" do
      expect(paths.source).to eq(source_path)
    end

    it "uses the source path to construct a compile path" do
      expect(paths.compile).to eq(source_path + "/public")
    end
  end

  context 'when both paths are initialized' do
    let(:compile_path)  { File.dirname(__FILE__) + "/support/public" }
    let(:paths)         { Prow::Paths.new(source_path, compile_path) }

    it "uses what it is given" do
      expect(paths.source).to eq(source_path)
      expect(paths.compile).to eq(compile_path)
    end
  end

  describe 'composite paths' do
    it "constructs a templates path from the source directory" do
      expect(paths.templates).to eq(source_path + "/templates")
    end

    it "contructs a sass path from the source directory" do
      expect(paths.sass). to eq(source_path + "/sass")
    end

    it "constructs a configuration directory from the source" do
      expect(paths.config). to eq(source_path + "/config")
    end

    it "constructs a pages_config from the config path" do
      expect(paths.pages_config).to eq(source_path + "/config/pages.json")
    end
  end
end
