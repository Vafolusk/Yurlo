module UI
  class Transition

    def initialize()
    end

    def noise 
      window = Ncurses.newwin 25, 80, 0, 0
      200.times do
        c = rand(64)
        x = rand(80)
        y = rand(25)
        window.color_set c, nil
        window.mvaddstr y, x, '0'
        $game.redraw
        window.refresh
        sleep 0.01
      end
    end

    def falling_curtain 
      window = Ncurses.newwin 25, 80, 0, 0
      window.color_set Palette::BLACK_ON_RED, nil

      25.times do |y| 
        80.times do |x|
          window.mvaddstr y, x, '*'
          window.refresh
        end
        sleep 0.015
      end
      window.delwin
    end

    def rising_curtain 
      window = Ncurses.newwin 25, 80, 0, 0
      window.color_set Palette::WHITE_ON_BLUE, nil
      Term.set_cursor_pos 79, 24
      25.times do |y| 
        80.times do |x|
          window.mvaddstr 24 - y, x, '~'
          window.refresh
        end
        sleep 0.015 
      end
      window.delwin
    end
  end
end

