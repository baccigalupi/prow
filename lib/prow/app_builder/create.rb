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
        create_and_move_stylesheets
      end

      def create_and_move_stylesheets
        ShipdStyle::CopyStylesheets.new(sass_path).perform
        FileUtils.mv(sass_path + "/shipd-all.scss", sass_path + "/all.scss")
        FileUtils.mv(sass_path + "/shipd-mobile.scss", sass_path + "/mobile.scss")
        FileUtils.mv(sass_path + "/shipd-tablet.scss", sass_path + "/tablet.scss")
        FileUtils.mv(sass_path + "/shipd-desktop.scss", sass_path + "/desktop.scss")
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

      def sass_path
        app_path + "/sass"
      end
    end
  end
end
