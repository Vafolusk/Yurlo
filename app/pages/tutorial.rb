
class Tutorial < Page

  def key_handlers
    {'b' => method(:exit)}
  end
  def initialize
    super 'test_template'
    UI::Transition.new.falling_curtain
    UI::Transition.new.rising_curtain
    @window = Ncurses.newwin 25, 80, 0, 0
  end

  def exit
    UI::Transition.new.noise 
    $game.log.info 'exiting tutorial'
    $game.pop_page
    $game.push_page Title.new
  end
end
