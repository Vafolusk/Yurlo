require 'rubygems'
require 'ncurses'

class Palette
  BLACK_ON_BLACK = 0
  BLACK_ON_RED = 1
  BLACK_ON_GREEN = 2
  BLACK_ON_YELLOW = 3
  BLACK_ON_BLUE = 4
  BLACK_ON_MAGENTA = 5
  BLACK_ON_CYAN = 6
  BLACK_ON_WHITE = 7
  RED_ON_BLACK = 8
  RED_ON_RED = 9
  RED_ON_GREEN = 10
  RED_ON_YELLOW = 11
  RED_ON_BLUE = 12
  RED_ON_MAGENTA = 13
  RED_ON_CYAN = 14
  RED_ON_WHITE = 15
  GREEN_ON_BLACK = 16
  GREEN_ON_RED = 17
  GREEN_ON_GREEN = 18
  GREEN_ON_YELLOW = 19
  GREEN_ON_BLUE = 20
  GREEN_ON_MAGENTA = 21
  GREEN_ON_CYAN = 22
  GREEN_ON_WHITE = 23
  YELLOW_ON_BLACK = 24
  YELLOW_ON_RED = 25
  YELLOW_ON_GREEN = 26
  YELLOW_ON_YELLOW = 27
  YELLOW_ON_BLUE = 28
  YELLOW_ON_MAGENTA = 29
  YELLOW_ON_CYAN = 30
  YELLOW_ON_WHITE = 31
  BLUE_ON_BLACK = 32
  BLUE_ON_RED = 33
  BLUE_ON_GREEN = 34
  BLUE_ON_YELLOW = 35
  BLUE_ON_BLUE = 36
  BLUE_ON_MAGENTA = 37
  BLUE_ON_CYAN = 38
  BLUE_ON_WHITE = 39
  MAGENTA_ON_BLACK = 40
  MAGENTA_ON_RED = 41
  MAGENTA_ON_GREEN = 42
  MAGENTA_ON_YELLOW = 43
  MAGENTA_ON_BLUE = 44
  MAGENTA_ON_MAGENTA = 45
  MAGENTA_ON_CYAN = 46
  MAGENTA_ON_WHITE = 47
  CYAN_ON_BLACK = 48
  CYAN_ON_RED = 49
  CYAN_ON_GREEN = 50
  CYAN_ON_YELLOW = 51
  CYAN_ON_BLUE = 52
  CYAN_ON_MAGENTA = 53
  CYAN_ON_CYAN = 54
  CYAN_ON_WHITE = 55
  WHITE_ON_BLACK = 56
  WHITE_ON_RED = 57
  WHITE_ON_GREEN = 58
  WHITE_ON_YELLOW = 59
  WHITE_ON_BLUE = 60
  WHITE_ON_MAGENTA = 61
  WHITE_ON_CYAN = 62
  WHITE_ON_WHITE = 63

  def initialize
    Ncurses.init_pair 0, Ncurses::COLOR_BLACK, Ncurses::COLOR_BLACK
    Ncurses.init_pair 1, Ncurses::COLOR_BLACK, Ncurses::COLOR_RED
    Ncurses.init_pair 2, Ncurses::COLOR_BLACK, Ncurses::COLOR_GREEN
    Ncurses.init_pair 3, Ncurses::COLOR_BLACK, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 4, Ncurses::COLOR_BLACK, Ncurses::COLOR_BLUE
    Ncurses.init_pair 5, Ncurses::COLOR_BLACK, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 6, Ncurses::COLOR_BLACK, Ncurses::COLOR_CYAN
    Ncurses.init_pair 7, Ncurses::COLOR_BLACK, Ncurses::COLOR_WHITE
    Ncurses.init_pair 8, Ncurses::COLOR_RED, Ncurses::COLOR_BLACK
    Ncurses.init_pair 9, Ncurses::COLOR_RED, Ncurses::COLOR_RED
    Ncurses.init_pair 10, Ncurses::COLOR_RED, Ncurses::COLOR_GREEN
    Ncurses.init_pair 11, Ncurses::COLOR_RED, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 12, Ncurses::COLOR_RED, Ncurses::COLOR_BLUE
    Ncurses.init_pair 13, Ncurses::COLOR_RED, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 14, Ncurses::COLOR_RED, Ncurses::COLOR_CYAN
    Ncurses.init_pair 15, Ncurses::COLOR_RED, Ncurses::COLOR_WHITE
    Ncurses.init_pair 16, Ncurses::COLOR_GREEN, Ncurses::COLOR_BLACK
    Ncurses.init_pair 17, Ncurses::COLOR_GREEN, Ncurses::COLOR_RED
    Ncurses.init_pair 18, Ncurses::COLOR_GREEN, Ncurses::COLOR_GREEN
    Ncurses.init_pair 19, Ncurses::COLOR_GREEN, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 20, Ncurses::COLOR_GREEN, Ncurses::COLOR_BLUE
    Ncurses.init_pair 21, Ncurses::COLOR_GREEN, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 22, Ncurses::COLOR_GREEN, Ncurses::COLOR_CYAN
    Ncurses.init_pair 23, Ncurses::COLOR_GREEN, Ncurses::COLOR_WHITE
    Ncurses.init_pair 24, Ncurses::COLOR_YELLOW, Ncurses::COLOR_BLACK
    Ncurses.init_pair 25, Ncurses::COLOR_YELLOW, Ncurses::COLOR_RED
    Ncurses.init_pair 26, Ncurses::COLOR_YELLOW, Ncurses::COLOR_GREEN
    Ncurses.init_pair 27, Ncurses::COLOR_YELLOW, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 28, Ncurses::COLOR_YELLOW, Ncurses::COLOR_BLUE
    Ncurses.init_pair 29, Ncurses::COLOR_YELLOW, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 30, Ncurses::COLOR_YELLOW, Ncurses::COLOR_CYAN
    Ncurses.init_pair 31, Ncurses::COLOR_YELLOW, Ncurses::COLOR_WHITE
    Ncurses.init_pair 32, Ncurses::COLOR_BLUE, Ncurses::COLOR_BLACK
    Ncurses.init_pair 33, Ncurses::COLOR_BLUE, Ncurses::COLOR_RED
    Ncurses.init_pair 34, Ncurses::COLOR_BLUE, Ncurses::COLOR_GREEN
    Ncurses.init_pair 35, Ncurses::COLOR_BLUE, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 36, Ncurses::COLOR_BLUE, Ncurses::COLOR_BLUE
    Ncurses.init_pair 37, Ncurses::COLOR_BLUE, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 38, Ncurses::COLOR_BLUE, Ncurses::COLOR_CYAN
    Ncurses.init_pair 39, Ncurses::COLOR_BLUE, Ncurses::COLOR_WHITE
    Ncurses.init_pair 40, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_BLACK
    Ncurses.init_pair 41, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_RED
    Ncurses.init_pair 42, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_GREEN
    Ncurses.init_pair 43, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 44, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_BLUE
    Ncurses.init_pair 45, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 46, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_CYAN
    Ncurses.init_pair 47, Ncurses::COLOR_MAGENTA, Ncurses::COLOR_WHITE
    Ncurses.init_pair 48, Ncurses::COLOR_CYAN, Ncurses::COLOR_BLACK
    Ncurses.init_pair 49, Ncurses::COLOR_CYAN, Ncurses::COLOR_RED
    Ncurses.init_pair 50, Ncurses::COLOR_CYAN, Ncurses::COLOR_GREEN
    Ncurses.init_pair 51, Ncurses::COLOR_CYAN, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 52, Ncurses::COLOR_CYAN, Ncurses::COLOR_BLUE
    Ncurses.init_pair 53, Ncurses::COLOR_CYAN, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 54, Ncurses::COLOR_CYAN, Ncurses::COLOR_CYAN
    Ncurses.init_pair 55, Ncurses::COLOR_CYAN, Ncurses::COLOR_WHITE
    Ncurses.init_pair 56, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK
    Ncurses.init_pair 57, Ncurses::COLOR_WHITE, Ncurses::COLOR_RED
    Ncurses.init_pair 58, Ncurses::COLOR_WHITE, Ncurses::COLOR_GREEN
    Ncurses.init_pair 59, Ncurses::COLOR_WHITE, Ncurses::COLOR_YELLOW
    Ncurses.init_pair 60, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLUE
    Ncurses.init_pair 61, Ncurses::COLOR_WHITE, Ncurses::COLOR_MAGENTA
    Ncurses.init_pair 62, Ncurses::COLOR_WHITE, Ncurses::COLOR_CYAN
    Ncurses.init_pair 63, Ncurses::COLOR_WHITE, Ncurses::COLOR_WHITE
  end
end

#colors=['BLACK',
#'RED',
#'GREEN',
#'YELLOW',
#'BLUE',
#'MAGENTA',
#'CYAN',
#'WHITE']
#
#x = 0
#colors.each do |fg|
#  colors.each do |bg|
#    puts "#{fg}_ON_#{bg} = #{x.to_s}"
#    x += 1
#  end
#end
#x = 0
#colors.each do |fg|
#  colors.each do |bg|
#    puts "Ncurses.init_pair #{x.to_s}, Ncurses::COLOR_#{fg}, Ncurses::COLOR_#{bg}"
#    x += 1
#  end
#end

