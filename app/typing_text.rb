class TypingText
  def initialize(template_name)
    @template_name = template_name
    @multiline = true
  end

  def begin(window, x, y)
    start_x = x
    tr = TemplateRenderer.new 
    skip = false
    tr.render window, @template_name do |window, ch|
      window.timeout 0

      in_ch = window.getch
      if in_ch == 32
        skip = true
        $game.log.info 'skipping'
      end

      window.mvaddstr y, x, ch
      window.refresh
      if !skip
        sleep 0.05
      end
      if ch == "\n" 
        if !@multiline
          window.timeout -1
          window.getch
          window.refresh
          skip = false
          x = start_x
          window.move y, x
          window.clrtoeol
          window.refresh
          x = start_x
        else
          x = start_x
          y += 1
        end
      else
        x += 1
      end
    end

    window.timeout -1
  end
end
