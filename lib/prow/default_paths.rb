module Prow
  class DefaultPaths
    def base_path
      File.dirname(__FILE__) + "/.."
    end

    def config_path
      "#{base_path}/pages.json"
    end

    def templates_path
      "#{base_path}/templates"
    end

    def compiled_path
      "#{base_path}/public"
    end
  end
end
