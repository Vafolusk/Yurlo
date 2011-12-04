class Background < Page

  def initialize
    super 'background'
    Term.set_cursor_pos 0,0
    Term.erase_screen
  end

  def begin
    Term.set_cursor_pos 0, 6
    st = UI::TypingText.new 'history'
    st.begin
    sleep 1 

    Term.set_cursor_pos 0, 24
    printf '[b] - Back'
  end

  def key_handlers
    {'b' => method(:exit)}
  end

  def exit
    $game.pop_page
    $game.push_page Title.new
  end
end
