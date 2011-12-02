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
  end

  def exit
    $game.log.info 'exiting help'
    $game.pop_page
  end
end
