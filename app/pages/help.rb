
class Help < Page

  def key_handlers
    {'b' => method(:exit)}
  end

  def initialize
    super 'help'
    self.border = true
    @window = Ncurses.newwin 10, 20, 5, 30
  end

  def exit
    $game.log.info 'exiting help'
    $game.pop_page
  end
end
