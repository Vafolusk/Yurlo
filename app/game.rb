require 'rubygems'

class Game
  attr_accessor :debug
  attr_accessor :win

  def initialize
    @ui = NcursesUI.new
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
    @ui.shutdown
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
    redraw
  end

  def pop_page
    @page_stack.pop
    if @page_stack.size > 0
      @input.handlers = @page_stack.last.key_handlers
    end
    redraw
  end

  def title 
    push_page Title.new
  end

  def map
    #trans = UI::Transition.new
    #trans.falling_curtain
    #trans.rising_curtain
    push_page Scroller.new
  end

  def begin()
    map
    forever do
      @input.process
    end
  end

  def redraw()
    @page_stack.each do |page|
      page.draw
    end
  end

  def log 
    @log
  end
end
