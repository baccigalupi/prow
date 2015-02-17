require 'spec_helper'

describe Prow::PageCompiler do
  let(:compiler)     { Prow::PageCompiler.new(page, templates, compile_dir) }
  let(:page)         { Prow::Page.new([name, config]) }
  let(:paths)        { Prow::Paths.new(File.dirname(__FILE__) + "/support/fixtures") }

  let(:full_configs) { JSON.parse(File.read(paths.pages_config))['pages'] }
  let(:config)       { full_configs[name]}
  let(:name)         { 'index.html' }
  let(:templates)    { Prow::Templates.new(paths.templates) }
  let(:compile_dir)  { paths.compile }
  let(:file_path)    { paths.compile + "/index.html" }

  before { File.delete(file_path) if File.exist?(file_path) }

  let(:content) { File.read(file_path) }

  it "should generate the right path" do
    expect(compiler.path).to eq(file_path)
  end

  describe '#compile' do
    it 'should generate a file at the path' do
      compiler.compile
      expect(File.exist?(file_path)).to be(true)
    end

    context 'with default layout' do
      it "should have layout content" do
        compiler.compile
        expect(content).to include("DEFAULT LAYOUT")
      end

      it "should render data into the layout" do
        compiler.compile
        expect(content).to include("hello Prow")
      end
    end

    context 'with specified layout' do
      let(:name) { 'foo.html' }
      let(:content) { File.read(compile_dir + "/foo.html") }

      it "should have layout content" do
        compiler.compile
        expect(content).to include("FOO LAYOUT")
      end
    end

    it "should render the body view" do
      compiler.compile
      expect(content).to include("Hello, home page!")
    end

    it "should render the partials called from the layout" do
      compiler.compile
      expect(content).to include("Hello Header World")
    end

    it "should render data in the body" do
      compiler.compile
      expect(content).to include("data sample")
    end

    it "should render partials called from the body" do
      compiler.compile
      expect(content).to include("Hello, it!")
    end
  end
end
