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

  def draw_border
    Ncurses.wborder(window, ?|, ?|, ?-, ?-, ?+, ?+, ?+, ?+)
  end
end

