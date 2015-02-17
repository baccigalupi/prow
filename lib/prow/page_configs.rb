module Prow
  class PageConfigs < Struct.new(:path)
    extend Forwardable

    def load
      JSON.parse(File.read(path))
    end

    def pages_array
      load['pages'] || []
    end

    def collection
      @collection ||= pages_array.map do |config|
        Page.new(config)
      end
    end

    def_delegators :collection, :each, :size
  end
end
