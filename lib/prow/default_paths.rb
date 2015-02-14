module Prow
  class DefaultPaths
    def base_path
      `pwd`.chomp
    end

    def config_path
      "#{base_path}/pages.json"
    end

    def templates_path
      "#{base_path}/templates"
    end

    def compile_path
      "#{base_path}/public"
    end
  end
end
