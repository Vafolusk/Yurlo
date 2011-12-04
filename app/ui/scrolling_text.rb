module UI
  class ScrollingText

    def initialize(template_name)
      @text = TemplateRenderer.new.eval(template_name)
      puts @text
    end

    def begin()
      Term.set_cursor_pos 0, 0
      lines = @text.split "\n"

      while lines.size > 0:
        lines.each do |line|
          puts line
        end
        sleep 0.05
        lines.shift
        Term.set_cursor_pos 0, 0
        erase_screen
      end
    end

  end
end

