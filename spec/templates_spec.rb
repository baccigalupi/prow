require 'spec_helper'

RSpec.describe Prow::Templates do
  let(:templates) { Prow::Templates.new(templates_path) }
  let(:templates_path) { File.dirname(__FILE__) + "/support/fixtures/templates" }

  describe '#layout' do
    it "returns layouts via name" do
      layout = templates.layout('default')
      expect(layout).to be_a(Prow::Template)
      expect(layout.name).to eq('default')
      expect(layout.content).to eq(File.read(templates_path + "/layouts/default.mustache"))
    end

    it "raises an error if named layout not found" do
      expect { templates.layout('not-here') }.to raise_error
    end

    it "returns the default if no argument is passed in" do
      expect(templates.layout).to eq(templates.layout('default'))
    end
  end

  describe '#page' do
    it "returns the right partial" do
      expect(templates.page('index').name).to eq('index')
    end
  end

  describe '#partials' do
    it "returns all of the partials" do
      expect(templates.partials.size).to be > 2
      expect(templates.partials.map(&:name)).to include("things/it", "header")
    end
  end
end
