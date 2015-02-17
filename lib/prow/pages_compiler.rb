module Prow
  class PagesCompiler
    attr_reader :paths

    def initialize(paths=nil)
      @paths = paths || Paths.new
    end

    def compile
      page_configs.each do |page|
        PageCompiler.new(page, templates, paths.compile).compile
      end
    end

    def page_configs
      @page_configs ||= PageConfigs.new(paths.pages_config)
    end

    def templates
      @templates ||= Templates.new(paths.templates)
    end
  end
end
