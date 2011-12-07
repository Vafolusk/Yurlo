
class Title < Page
  def initialize
    super 'title'
    @handlers = {'n' => method(:map), 't' => method(:tutorial), 'h' => method(:help), 'B' => method(:background), 'q' => method(:quit)}
    @window = Ncurses.newwin 25, 80, 0, 0
  end

  def key_handlers
    @handlers
  end

  def background
    $game.pop_page
    page = Background.new
    $game.push_page page
    page.begin
  end

  def tutorial
    $game.pop_page
    $game.push_page Tutorial.new
  end

  def help
    page = Help.new 
    $game.push_page page
  end

  def quit
    $game.quit
  end

  def map
    $game.map
  end
end
