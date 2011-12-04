module UI
  class Transition

    def initialize()
    end

    def noise
      200.times do
        fg = rand(Term::BG_RED + (Term::BG_WHITE - Term::BG_RED))
        x = rand(80)
        y = rand(25)
        Term.set_cursor_pos x, y
        Term.set_display_attributes [fg]
        sleep 0.01
        puts '0'
      end
      Term.set_cursor_pos 0, 0
      Term.erase_screen
      Term.reset
    end

    def falling_curtain
      Term.set_cursor_pos 0, 0
      Term.erase_screen
      Term.set_display_attributes [Term::BG_RED, Term::FG_BLACK]

      25.times do |y| 
        80.times do |x|
          Term.set_cursor_pos x, y 
          puts '*'
        end
        sleep 0.015
      end
    end

    def rising_curtain
      Term.set_display_attributes [Term::BG_BLUE, Term::FG_WHITE]
      Term.set_cursor_pos 79, 24
      25.times do |y| 
        80.times do |x|
          Term.set_cursor_pos x, 24-y 
          puts '~'
        end
        sleep 0.015 
      end
    end
  end
end

