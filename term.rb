class Term
  ESC = "\033"
  RESET = 0 
  BRIGHT = 1
  DIM = 2
  UNDERSCORE = 4
  BLINK = 5
  REVERSE = 7
  HIDDEN = 8
  FG_BLACK = 30
  FG_RED = 31
  FG_GREEN = 32
  FG_YELLOW = 33
  FG_BLUE = 34
  FG_MAGENTA = 35
  FG_CYAN = 36
  FG_WHITE = 37
  BG_BLACK = 40
  BG_RED = 41
  BG_GREEN = 42
  BG_YELLOW = 43
  BG_BLUE = 44
  BG_MAGENTA = 45
  BG_CYAN = 46
  BG_WHITE = 47
  class << self
    def esc
      printf ESC
    end

    def encode(cmd)
      ESC + cmd 
    end

    def send(cmd)
      printf encode(cmd)
    end

    def set_cursor_pos(x, y)
      cursor_home(y, x)
    end

    def cursor_home(row, column)
      send "[#{row};#{column}H"
    end

    def reset()
      send "c"
    end

    def encode_display_attributes(attrs)
      return if attrs.length == 0
      cmd = '['
      attrs.each do |i|
        cmd += "#{i};"
      end
      cmd.chop!
      cmd += 'm'
      encode cmd
    end

    def set_display_attributes(attrs)
      send encode_display_attributes(attrs)
    end

    def reset_attributes()
      set_display_attributes([RESET])
    end

    def erase_screen()
      send "[2J"
    end

    def erase_up()
      send "[1J"
    end

    def cursor_back(count)
      send "[#{count}D"
    end

    def reset_all
      set_cursor_pos 0, 0
      reset_attributes
      erase_screen
    end
  end
end
