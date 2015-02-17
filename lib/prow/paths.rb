module Prow
  class Paths < Struct.new(:source_path, :compile_path)
    def source
      source_path || `pwd`.chomp
    end

    def compile
      compile_path || source + "/public"
    end

    [:templates, :sass, :config].each do |path|
      define_method(path) { composite_path(source, path) }
    end

    def pages_config
      config + "/pages.json"
    end

    def stylesheets
      composite_path(compile, "/stylesheets")
    end

    def composite_path(start_path, end_path)
      "#{start_path}/#{end_path}"
    end
  end
end
