module Prow
  module AppBuilder
    class StyleCompiler
      def perform
        `compass compile --css-dir=public/stylesheets`
      end

      def self.perform
        new.perform
      end
    end
  end
end
