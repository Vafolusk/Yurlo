require File.dirname(__FILE__) + '/boot'

begin
  $game = Game.new
  $game.begin
	puts "OK"
rescue Exception => e
  Term.set_display_attributes [Term::FG_RED, Term::BG_BLACK]
  puts e.inspect
  puts e.backtrace
ensure
  $game.quit
end

puts
puts 'bye!'

