class Log
  def initialize
    @log = open '/tmp/roguelike.log', 'w'
  end

  def info(str)
    @log.puts 'info: ' + str
  end

  def error(str)
    @log.puts 'error:' + str
  end

  def warning(str)
    @log.puts 'warning:' + str
  end
end

