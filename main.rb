require 'game'
require 'term'

begin
  $game = Game.new
  $game.begin
rescue Exception => e
  Term.set_display_attributes [Term::FG_RED, Term::BG_BLACK]
  puts e.inspect
  puts e.backtrace
ensure
  $game.quit
end

