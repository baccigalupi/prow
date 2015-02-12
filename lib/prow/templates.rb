module Prow
  class Templates < Struct.new(:path)
    def layout(name='default')
      template('layouts', name)
    end

    def page(name)
      template('pages', name)
    end

    def partial(name)
      partials.detect {|t| t.name == name}
    end

    def partials
      collection.select {|template| template.type == 'partials' }
    end

    def template(type, name)
      found = collection.detect { |template| template.type == type && template.name == name }
      raise ArgumentError.new("#{type} #{name} not found") unless found
      found
    end

    def collection
      @collection ||= load
    end

    def load
      Dir.glob("#{path}/**/*.mustache").map do |template_path|
        Template.new(template_path, path)
      end
    end
  end
end
