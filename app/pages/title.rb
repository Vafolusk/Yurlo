
class Title < Page
  def initialize
    super 'title'
    @handlers = {'t' => method(:tutorial), 'h' => method(:help), 'B' => method(:background), 'q' => method(:quit)}
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
end
