class Page
  attr_accessor :bbox
  attr_accessor :border
  attr_accessor :window

  def key_handlers
    {'b' => method(:quit)}
  end

  def quit
    $game.pop_page
  end

  def initialize(template_name)
    @bbox = {:x =>1, :y => 1, :width => 80, :height => 25}
    @border = false
    @template_renderer = TemplateRenderer.new
    @template_name = template_name
  end

  def draw
    if @template_name
      @template_renderer.render window, @template_name
    end

    if @border
      draw_border
    end
  end

  def draw_horiz_line(x, y, len)
    Term.set_cursor_pos x, y
    printf '+'
    w = len - 2
    w.times do 
      printf '-'
    end
    printf '+'
  end

  def draw_border
    Ncurses.wborder(window, ?|, ?|, ?-, ?-, ?+, ?+, ?+, ?+)
  end

  def old_draw_border
    draw_horiz_line bbox[:x], bbox[:y], bbox[:width]
    h = bbox[:height] 

    y = bbox[:y] + 1
    h.times do
      Term.set_cursor_pos bbox[:x], y
      printf '|'
      Term.set_cursor_pos bbox[:x] + bbox[:width] - 1, y
      printf '|'
      y += 1
    end

    draw_horiz_line bbox[:x], bbox[:y] + h, bbox[:width]
  end

  def clear_bbox
    Term.set_display_attributes [Term::RESET]
    y = bbox[:y]
    Term.set_cursor_pos bbox[:x], y
    bbox[:height].times do
      x = bbox[:x]
      y += 1
      bbox[:width].times do 
        Term.set_cursor_pos x, y
        x += 1
        printf ' '
      end
    end
  end
end

