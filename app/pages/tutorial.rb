
class Tutorial < Page

  def key_handlers
    {'b' => method(:exit)}
  end
  def initialize
    super 'test_template'
    Transition.new.falling_curtain
    Transition.new.rising_curtain
    @window = Ncurses.newwin 25, 80, 0, 0
  end

  def exit
    Transition.new.noise 
    $game.log.info 'exiting tutorial'
    $game.pop_page
    $game.push_page Title.new
  end
end
