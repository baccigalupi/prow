module Prow
  class PageConfigs < Struct.new(:path)
    extend Forwardable

    def load
      JSON.parse(File.read(path))
    end

    def collection
      @collection ||= load['pages'] || []
    end

    def_delegators :collection, :each, :size
  end
end
