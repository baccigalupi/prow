module Prow
  class Page < Struct.new(:config_array)
    def file_name
      config_array.first
    end

    def config
      config_array.last
    end

    def layout
      config['layout'] || 'default'
    end

    def data
      config['data'] || {}
    end

    def name
      file_name.split('.').first
    end
  end
end
