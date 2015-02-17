module Prow
  class Watcher < Struct.new(:paths)
    def start
      watch_all
    end

    def stop
      template_listener.stop
    end

    def watch_all
      silence_warnings do
        template_listener.start
        sass_listener.start
      end
    end

    def template_listener
      @template_listener ||= Listen.to(paths.templates) do
        compile_pages
      end
    end

    def sass_listener
      @sass_listener ||= Listen.to(paths.sass) do
        compile_stylesheets
      end
    end

    def compile_pages
      Prow::PagesCompiler.new(paths).compile
    end

    def compile_stylesheets
      Prow::AppBuilder::StyleCompiler.new(paths).perform
    end
  end
end
