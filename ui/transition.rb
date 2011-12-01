module UI
  class Transition
    include Term

    def initialize()
    end

    def noise
      200.times do
        fg = rand(Term::BG_RED + (Term::BG_WHITE - Term::BG_RED))
        x = rand(80)
        y = rand(25)
        set_cursor_pos x, y
        set_display_attributes [fg]
        sleep 0.01
        puts '0'
      end
      set_cursor_pos 0, 0
      erase_screen
    end

    def falling_curtain
      set_cursor_pos 0, 0
      erase_screen
      set_display_attributes [Term::BG_RED, Term::FG_BLACK]

      25.times do |y| 
        80.times do |x|
          set_cursor_pos x, y 
          puts '*'
        end
        sleep 0.015
      end
    end

    def rising_curtain
      set_display_attributes [Term::BG_BLUE, Term::FG_WHITE]
      set_cursor_pos 79, 24
      25.times do |y| 
        80.times do |x|
          set_cursor_pos x, 24-y 
          puts '~'
        end
        sleep 0.015 
      end
    end
  end
end

