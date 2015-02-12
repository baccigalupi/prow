module Prow
  class Template < Struct.new(:path, :templates_path)
    def type
      path_parts.first
    end

    def name
      name_path_parts.join('/')
    end

    def content
      @content ||= File.read(path)
    end

    def partial_path
      path.gsub(templates_path, '')
    end

    def path_parts
      partial_path.split("/").select{|p| !p.empty? }
    end

    def name_path_parts
      (path_parts - [type]).map {|e| e.split('.').first }
    end
  end
end
