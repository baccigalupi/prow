require 'spec_helper'

describe Prow::Watcher do
  let(:runner) { Prow::Watcher.new(paths) }
  let(:paths)  { Prow::Paths.new(File.dirname(__FILE__) + "/support/fixtures" )}

  before do
    # create some initial content
    Prow::PagesCompiler.new(paths).compile
  end

  after do
    runner.stop
  end

  describe '#start' do
    context 'when templates change' do
      after do
        File.open(header_template_path, 'w') do |f|
          f.write(original_header_content)
        end
      end

      let(:header_template_path) { paths.templates + "/partials/header.mustache" }
      let(:new_header_content) { "Yo, header!" }
      let(:original_header_content) { "Hello Header World\n" }

      it "regenerates pages" do
        runner.start
        File.open(header_template_path, 'w') do |f|
          f.write(new_header_content)
        end
        sleep 1
        expect(File.read(paths.compile + "/index.html")).to include(new_header_content)
      end
    end

    context 'when the pages.json changes' do
      it "regenerates pages"
    end

    context 'when sass files change' do
      let(:scss_path) { paths.sass + "/foo.scss" }
      let(:stylesheet_path) { paths.compile + "/stylesheets/foo.css" }

      before do
        File.delete(scss_path) if File.exist?(scss_path)
        File.delete(stylesheet_path) if File.exist?(stylesheet_path)
      end

      it "watches sass files and regenerates stylesheets" do
        runner.start
        File.open(scss_path, 'w') {|f| f.write("body {background: red;}") }
        sleep 1
        expect(File.exist?(stylesheet_path)).to be(true)
      end
    end
  end
end
