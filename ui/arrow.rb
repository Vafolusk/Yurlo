require 'term/ansi'

module UI
  class Arrow
    extend Term
    def self.down_arrow(x, y)
      set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      set_cursor_pos x, y-5
      puts '#'
      set_cursor_pos x , y-4
      puts '#'
      set_cursor_pos x, y-3 
      puts '#'
      set_cursor_pos x-2, y-2
      puts '#####'
      set_cursor_pos x-1, y-1
      puts '###'
      set_cursor_pos x, y
      puts '#'
    end

    def self.up_arrow(x, y)
      set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      set_cursor_pos x, y
      puts '#'
      set_cursor_pos x-1 , y+1
      puts '###'
      set_cursor_pos x-2, y+2 
      puts '#####'
      set_cursor_pos x, y+3
      puts '#'
      set_cursor_pos x, y+4 
      puts '#'
      set_cursor_pos x, y+5
      puts '#'
    end

    def self.left_arrow(x, y)
      set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      set_cursor_pos x+2, y-2
      puts '#'
      set_cursor_pos x+1, y-1 
      puts '##'
      set_cursor_pos x, y
      puts '#######'
      set_cursor_pos x+1, y+1
      puts '##'
      set_cursor_pos x+2, y+2
      puts '#'
    end

    def self.right_arrow(x, y)
      set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      set_cursor_pos x-2, y-2
      puts '#'
      set_cursor_pos x-2, y-1 
      puts '##'
      set_cursor_pos x-6, y
      puts '#######'
      set_cursor_pos x-2, y+1
      puts '##'
      set_cursor_pos x-2, y+2
      puts '#'
    end

    def self.small_right_arrow(x, y)
      set_cursor_pos x-1, y
      '->'
    end

    def self.small_right_arrow(x, y)
      set_cursor_pos x, y
      '<-'
    end

    def self.small_up_arrow(x, y)
      set_display_attributes [Term::BG_BLUE, Term::FG_RED]
      set_cursor_pos x, y
      puts '.'
      set_cursor_pos x-1, y+1
      puts '/_\\'
      set_cursor_pos x, y+2
      puts '|'
    end
    def self.small_down_arrow(x, y)
      set_display_attributes [Term::BG_BLUE, Term::FG_RED]
      set_cursor_pos x, y-2
      puts '|'
      set_cursor_pos x-1, y-1
      puts '\\ /'
      set_cursor_pos x, y
      puts '.'
    end

    def self.diagonal_arrow(x, y)
    end
  end
end
