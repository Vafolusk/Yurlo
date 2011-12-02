require 'term'
require 'ui'

class Page
  attr_accessor :bbox
  attr_accessor :border

  def key_handlers
    {'b', method(:quit)}
  end

  def quit
    $game.pop_page
  end

  def initialize(template_name)
    @bbox = {:x =>1, :y => 1, :width => 80, :height => 25}
    @border = false
    @template_renderer = UI::TemplateRenderer.new
    @template_name = template_name
  end

  def draw
    Term.set_cursor_pos @bbox[:x], @bbox[:y]
    @template_renderer.render @template_name if @template_name
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
    draw_horiz_line bbox[:x], bbox[:y], bbox[:width]
    h = bbox[:height] - 2

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
end

