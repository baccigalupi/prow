module Prow
  class PageCompiler < Struct.new(:page, :templates, :compile_dir)
    def compile
      make_parent_directory
      File.open(path, 'w+') do |f|
        f.write(render)
      end
    end

    def renderer
      return @renderer if defined?(@renderer)
      @renderer = Renderer.new
      @renderer.templates = templates
      @renderer.page_name = page.name
      @renderer
    end

    def render
      renderer.render(layout.content, page.data)
    end

    def layout
      templates.layout(page.layout)
    end

    def make_parent_directory
      FileUtils.mkdir_p(page_dir) unless File.exist?(page_dir)
    end

    def page_dir
      compile_dir + "/" + page_path
    end

    def page_path
      page.file_name.split('/')[0..-2].join("/")
    end

    def path
      compile_dir + "/" + page.file_name
    end
  end
end
