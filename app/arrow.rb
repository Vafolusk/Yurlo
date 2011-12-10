class Arrow
  def self.down_arrow(window, x, y)
    window.mvaddstr y-5, x, '#'
    window.mvaddstr y-4, x, '#'
    window.mvaddstr y-3, x, '#'
    window.mvaddstr y-2, x-2, '#####'
    window.mvaddstr y-1, x-1, '###'
    window.mvaddstr y, x, '#'
  end

  def self.up_arrow(window, x, y)
    window.mvaddstr y, x, '#'
    window.mvaddstr y+1, x-1, '###'
    window.mvaddstr y+2, x-2, '#####'
    window.mvaddstr y+3, x, '#'
    window.mvaddstr y+4, x, '#'
    window.mvaddstr y+5, x, '#'
  end

  def self.left_arrow(window, x, y)
    window.mvaddstr y-2, x+2, '#'
    window.mvaddstr y-1, x+1, '##'
    window.mvaddstr y, x, '#######'
    window.mvaddstr y+1, x+1, '##'
    window.mvaddstr y+2, x+2, '#'
  end

  def self.right_arrow(window, x, y)
    window.mvaddstr y-2, x-2, '#'
    window.mvaddstr y-1, x-2, '##'
    window.mvaddstr y, x-6, '#######'
    window.mvaddstr y+1, x-2, '##'
    window.mvaddstr y+2, x-2, '#'
  end
end
