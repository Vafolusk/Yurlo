class Background < Page

  def initialize
    super 'background'
    @window = Ncurses.newwin 25, 80, 0, 0
  end

  def begin
    st = UI::TypingText.new 'history'
    st.begin @window, 5,  4
    sleep 1 

    @window.mvaddstr 16, 5, '[b] - Back'
  end

  def key_handlers
    {'b' => method(:exit)}
  end

  def exit
    $game.pop_page
    $game.push_page Title.new
  end
end
