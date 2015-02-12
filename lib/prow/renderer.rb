module Prow
  class Renderer < Mustache
    attr_accessor :templates, :page_name

    def partial(name)
      part = find_partial_template(name.to_s)
      part && part.content
    end

    def find_partial_template(name)
      return templates.page(page_name) if name == 'body'
      templates.partial(name)
    end
  end
end
