module Prow
  class PageCompiler < Struct.new(:page, :templates, :compile_dir)
    def compile
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

    def path
      compile_dir + "/" + page.file_name
    end
  end
end
