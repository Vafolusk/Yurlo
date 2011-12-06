require File.dirname(__FILE__) + '/boot'

begin
  $game = Game.new
  $game.begin
rescue Exception => e
  puts e.inspect
  puts e.backtrace
ensure
  $game.quit
end

puts
puts 'bye!'

