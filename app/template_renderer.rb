require 'erb'

class Template
  def initialize(params = {})
    @params = params
  end

  def color(c)
    "%c#{c.to_s}%"
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

  def write(window, ch)
    window.addstr ch
  end

  def render(window, template_name)
    buf = eval(template_name)
    state = :output
    value_buf = ''

    buf.chars.each do |ch|
      if state == :command
        if ch == 'c'
          state = :color_value
          value_buf = ''
        elsif ch == '%'
          window.addstr '%'
          state = :output
        end

      elsif state == :color_value
        if ch == '%'
          value = value_buf.to_i
          window.color_set(value, nil)
          state = :output
        else
          value_buf << ch
        end
      elsif state == :output
        if ch == '%'
          state = :command
        else
          if block_given?
            yield window, ch
          else
            write window, ch
          end
        end
      end
    end
  end
end
