require 'rubygems'
require 'ncurses'

class Input
  attr_accessor :handlers

  def initialize
    @handlers = {}
  end

  def process_key c
    k = c.chr
    $game.log.info @handlers.inspect
    if @handlers.has_key? k
      @handlers[k].call
    end
  end

  def process win
    if win
      process_key win.getch
    else
      process_key Ncurses.getch
    end
  end
end
