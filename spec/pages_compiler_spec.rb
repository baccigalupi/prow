require 'spec_helper'

RSpec.describe Prow::PagesCompiler do
  let(:pages) { Prow::PagesCompiler.new(config_path, templates_path, public_path) }
  let(:config_path)     { File.dirname(__FILE__) + "/support/pages.json" }
  let(:templates_path)  { File.dirname(__FILE__) + "/support/templates" }
  let(:public_path)     { File.dirname(__FILE__) + "/support/public" }

  describe '#compile' do
    before { pages.compile }

    it "compiles entries in pages.json" do
      expect(File.exist?(public_path + "/index.html")).to be(true)
      expect(File.exist?(public_path + "/foo.html")).to be(true)
    end

    it "does not compile pages that are not included in pages.json" do
      expect(File.exist?(public_path + "/bar.html")).to be(false)
    end
  end
end
