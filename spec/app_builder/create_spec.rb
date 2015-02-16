require 'spec_helper'

RSpec.describe Prow::AppBuilder::Create do
  let(:creator) { Prow::AppBuilder::Create.new(app_path) }
  let(:app_path) { File.dirname(__FILE__) + "/../support/app" }
  let(:app_templates_path) { File.dirname(__FILE__) + "/../../lib/prow/app_builder/templates" }

  before { `rm -rf #{app_path}/*` }

  it "should copy the config.ru file" do
    creator.perform
    expect(File.exist?(app_path + "/config.ru")).to be(true)
    expect(File.read(app_path + "/config.ru")).to eq(File.read(app_templates_path + "/config.ru"))
  end

  it "should make the public directory" do
    creator.perform
    expect(File.exist?(app_path + "/public")).to be(true)
  end

  it "should make the templates directory with each of its expected subdirectories" do
    creator.perform
    expect(File.exist?(app_path + "/templates")).to be(true)
    expect(File.exist?(app_path + "/templates/layouts")).to be(true)
    expect(File.exist?(app_path + "/templates/pages")).to be(true)
    expect(File.exist?(app_path + "/templates/partials")).to be(true)
  end

  it "should copy the pages.json file" do
    creator.perform
    expect(File.exist?(app_path + "/pages.json")).to be(true)
    expect(File.read(app_path + "/pages.json")).to eq(File.read(app_templates_path + "/pages.json"))
  end

  it "adds a sample layout and home page" do
    creator.perform
    expect(File.exist?(app_path + "/templates/layouts/default.mustache")).to be(true)
    expect(File.exist?(app_path + "/templates/pages/index.mustache")).to be(true)
  end

  it "copies over shipd style sass sheets" do
    creator.perform
    expect(File.exist?(app_path + "/sass/mobile")).to be(true)
  end

  it "renames the base style sheets to not include shipd" do
    creator.perform
    expect(File.exist?(app_path + "/sass/shipd-mobile.scss")).not_to be(true)
    expect(File.exist?(app_path + "/sass/mobile.scss")).to be(true)
  end

  it "copies over partial templates from shipd_style" do
    creator.perform
    expect(File.exist?(app_path + "/templates/partials/carousel.mustache")).to be(true)
  end
end
