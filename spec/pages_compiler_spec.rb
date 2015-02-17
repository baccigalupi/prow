require 'spec_helper'

RSpec.describe Prow::PagesCompiler do
  let(:pages) { Prow::PagesCompiler.new(paths) }
  let(:paths) { Prow::Paths.new(File.dirname(__FILE__) + "/support/fixtures") }

  describe '#compile' do
    before { pages.compile }

    it "compiles entries in pages.json" do
      expect(File.exist?(paths.compile + "/index.html")).to be(true)
      expect(File.exist?(paths.compile + "/foo.html")).to be(true)
    end

    it "does not compile pages that are not included in pages.json" do
      expect(File.exist?(paths.compile + "/bar.html")).to be(false)
    end
  end
end
