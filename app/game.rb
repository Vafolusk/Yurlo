
class Game
  attr_accessor :debug

  def initialize
    @input = UI::Input.new
    @page_stack = []

    @base_handlers = {}
    @base_handlers['q'] = method(:quit)

    @input.handlers = @base_handlers
    @done = false
    debug = true
    @log = Log.new
  end

  def quit
    @input.shutdown
    Term::set_display_attributes [Term::RESET]
    @done = true
  end

  def forever
    while !@done
      yield
    end
  end

  def push_page page
    @page_stack.push page
    @input.handlers = @page_stack.last.key_handlers
    Term.set_cursor_pos 0, 0
    Term.erase_screen
    redraw
  end

  def pop_page
    @page_stack.pop
    if @page_stack.size > 0
      @input.handlers = @page_stack.last.key_handlers
    end
    Term.set_cursor_pos 0, 0
    Term.erase_screen
    redraw
  end

  def title 
    push_page Title.new
  end

  def begin()
    title
    forever do
      @input.process
    end
  end

  def redraw()
    Term.set_cursor_pos 0, 0
    Term.erase_screen
    Term.reset
    @page_stack.each do |page|
      page.draw
    end
  end

  def log 
    @log
  end
end
