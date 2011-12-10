require 'rubygems'
require 'ncurses'

class Game
  attr_accessor :debug

  def initialize
    @input = Input.new
    @page_stack = []

    @base_handlers = {}
    @base_handlers['q'] = method(:quit)

    @input.handlers = @base_handlers
    @done = false
    debug = true
    @log = Log.new

    init_ncurses
  end

  def init_ncurses
    Ncurses.initscr
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.start_color

    @palette = Palette.new
  end

  def shutdown_ncurses
    Ncurses.endwin 
  end

  def quit
    $game.log.info 'shutting down...'
    shutdown_ncurses
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
    page.draw
  end

  def pop_page
    page = @page_stack.pop
    page.window.delwin if page.window
    if @page_stack.size > 0
      @input.handlers = @page_stack.last.key_handlers
    else
      @input.handlers = @base_handlers
    end
    redraw
  end

  def title 
    push_page Title.new
  end

  def map
    trans = Transition.new
    trans.falling_curtain
    push_page Scroller.new
    trans.rising_curtain
    redraw
  end

  def begin()
    title
    forever do
      if @page_stack.length > 0
        @input.process @page_stack.last.window
      else
        @input.process nil
      end
    end
  end

  def redraw
    @page_stack.each do |page|
      page.window.redrawwin if page.window
    end
  end

  def log 
    @log
  end
end
