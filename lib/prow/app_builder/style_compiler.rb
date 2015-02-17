module Prow
  module AppBuilder
    class StyleCompiler
      attr_reader :paths

      def initialize(paths = nil)
        @paths = paths || Paths.new
      end

      def perform
        `compass compile --sass-dir=#{paths.sass} --css-dir=#{paths.stylesheets}`
      end
    end
  end
end
