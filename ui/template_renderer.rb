require 'erb'
require 'term'

module UI
  class Template
    def initialize(params = {})
      @params = params
    end

    def opts(attrs)
      Term.encode_display_attributes attrs
    end

    def char_name
      'Hjalmar'
    end
  end

  class TemplateRenderer
    def eval(template_name)
      filename = "data/templates/#{template_name}.erb"
      erb = ERB.new(File.read(filename))
      erb.def_method(Template, 'render()')
      t = Template.new {}
      return t.render
    end

    def render(template_name)
      printf eval(template_name)
    end
  end
end
