module Prow
  module AppBuilder
    class Create < Struct.new(:path)
      def perform
        copy('config.ru')
        mkdir('public')
        mkdir('templates')
        mkdir('templates/layouts')
        mkdir('templates/pages')
        mkdir('templates/partials')
        copy('pages.json')
        copy('templates/layouts/default.mustache')
        copy('templates/pages/index.mustache')
        mkdir('sass')
        ShipdStyle::CopyStylesheets.new(app_path + "/sass").perform
      end

      def mkdir(dir)
        FileUtils.mkdir(app_path + "/" + dir) unless File.exist?(dir)
      end

      def copy(file_path)
        FileUtils.cp(templates_path + "/" + file_path, app_path + "/" + file_path)
      end

      def templates_path
        File.dirname(__FILE__) + "/templates"
      end

      def app_path
        path || `pwd`.chomp
      end
    end
  end
end
