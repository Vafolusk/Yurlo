
module UI
  class Arrow
    def self.down_arrow(x, y)
      Term.set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      Term.set_cursor_pos x, y-5
      puts '#'
      Term.set_cursor_pos x , y-4
      puts '#'
      Term.set_cursor_pos x, y-3 
      puts '#'
      Term.set_cursor_pos x-2, y-2
      puts '#####'
      Term.set_cursor_pos x-1, y-1
      puts '###'
      Term.set_cursor_pos x, y
      puts '#'
    end

    def self.up_arrow(x, y)
      Term.set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      Term.set_cursor_pos x, y
      puts '#'
      Term.set_cursor_pos x-1 , y+1
      puts '###'
      Term.set_cursor_pos x-2, y+2 
      puts '#####'
      Term.set_cursor_pos x, y+3
      puts '#'
      Term.set_cursor_pos x, y+4 
      puts '#'
      Term.set_cursor_pos x, y+5
      puts '#'
    end

    def self.left_arrow(x, y)
      Term.set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      Term.set_cursor_pos x+2, y-2
      puts '#'
      Term.set_cursor_pos x+1, y-1 
      puts '##'
      Term.set_cursor_pos x, y
      puts '#######'
      Term.set_cursor_pos x+1, y+1
      puts '##'
      Term.set_cursor_pos x+2, y+2
      puts '#'
    end

    def self.right_arrow(x, y)
      Term.set_display_attributes [Term::FG_RED, Term::BLINK, Term::BG_BLUE]
      Term.set_cursor_pos x-2, y-2
      puts '#'
      Term.set_cursor_pos x-2, y-1 
      puts '##'
      Term.set_cursor_pos x-6, y
      puts '#######'
      Term.set_cursor_pos x-2, y+1
      puts '##'
      Term.set_cursor_pos x-2, y+2
      puts '#'
    end

    def self.small_right_arrow(x, y)
      Term.set_cursor_pos x-1, y
      '->'
    end

    def self.small_right_arrow(x, y)
      Term.set_cursor_pos x, y
      '<-'
    end

    def self.small_up_arrow(x, y)
      Term.set_display_attributes [Term::BG_BLUE, Term::FG_RED]
      Term.set_cursor_pos x, y
      puts '.'
      Term.set_cursor_pos x-1, y+1
      puts '/_\\'
      Term.set_cursor_pos x, y+2
      puts '|'
    end
    def self.small_down_arrow(x, y)
      Term.set_display_attributes [Term::BG_BLUE, Term::FG_RED]
      Term.set_cursor_pos x, y-2
      puts '|'
      Term.set_cursor_pos x-1, y-1
      puts '\\ /'
      Term.set_cursor_pos x, y
      puts '.'
    end

    def self.diagonal_arrow(x, y)
    end
  end
end
