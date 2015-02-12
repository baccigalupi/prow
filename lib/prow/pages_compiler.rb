module Prow
  class PagesCompiler
    attr_reader :config_path, :templates_path, :compile_path

    def initialize(config_path=nil, templates_path=nil, compile_path=nil)
      @config_path = config_path || default_paths.config_path
      @templates_path = templates_path || default_paths.templates_path
      @compile_path = compile_path || default_paths.compile_path
    end

    def compile
      page_configs.each do |page_name, page_config|
        PageCompiler.new(page_name, page_config, templates, compile_path).compile
      end
    end

    def page_configs
      @page_configs ||= PageConfigs.new(config_path)
    end

    def templates
      @templates ||= Templates.new(templates_path)
    end

    def default_paths
      @default_paths ||= DefaultPaths.new
    end
  end
end
