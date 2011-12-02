require 'game'
require 'ui'
require 'term'
require 'page'

class Help < Page

  def key_handlers
    {'b' => method(:exit)}
  end

  def initialize
    super 'help'
    self.border = true
    self.bbox = { :x => 30, :y => 5, :width => 20, :height => 10 }
  end

  def exit
    $game.log.info 'exiting help'
    $game.pop_page
  end

end
