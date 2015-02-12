module Prow
  class PageCompiler < Struct.new(:name, :config, :templates, :compile_dir)
    def compile
      File.open(path, 'w+') do |f|
        f.write(render)
      end
    end

    def renderer
      return @renderer if defined?(@renderer)
      @renderer = Renderer.new
      @renderer.templates = templates
      @renderer.page_name = name.split('.').first
      @renderer
    end

    def render
      renderer.render(layout.content, data)
    end

    def layout
      templates.layout(config['layout'] || 'default')
    end

    def data
      config['data'] || {}
    end

    def path
      compile_dir + "/" + name
    end
  end
end
