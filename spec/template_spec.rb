require 'spec_helper'

RSpec.describe Prow::Template do
  let(:template) { Prow::Template.new(path, templates_path) }
  let(:path) { templates_path + "/layouts/default.mustache" }
  let(:templates_path) { File.dirname(__FILE__) + "/support/templates" }

  it "derives the type from the first directory name" do
    expect(template.type).to eq("layouts")
  end

  it "returns lazy the template content" do
    expect(template.instance_variable_get('@content')).to eq(nil)
    expect(template.content).to eq(File.read(path))
    expect(template.instance_variable_get('@content')).not_to eq(nil)
  end

  it "gets derives the name from the non-type end of the path" do
    expect(template.name).to eq('default')
  end

  context 'when the path is nested' do
    let(:path) { templates_path + "/partials/things/it.mustache" }

    it "correctly gets the type" do
      expect(template.type).to eq('partials')
    end

    it "correctly gets the name" do
      expect(template.name).to eq("things/it")
    end
  end
end
