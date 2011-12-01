module UI
  class ScrollingText
    include Term

    def initialize(template_name)
      @text = TemplateRenderer.new.eval(template_name)
      puts @text
    end

    def begin()
      set_cursor_pos 0, 0
      lines = @text.split "\n"

      while lines.size > 0:
        lines.each do |line|
          puts line
        end
        sleep 0.05
        lines.shift
        set_cursor_pos 0, 0
        erase_screen
      end
    end

  end
end

