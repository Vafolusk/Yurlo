require 'rubygems'
require 'ncurses'

VIEW_WIDTH=80
VIEW_HEIGHT=25

class Scroller < Page
  def initialize()
    super nil
    @world = World.new
    @view_x = 0
    @view_y = 0
    @view_width=VIEW_WIDTH
    @view_height=VIEW_HEIGHT
    @window = Ncurses.newwin(VIEW_HEIGHT, VIEW_WIDTH, 0, 0)
    @debug_box = nil
    @debug_show = false
  end

  def key_handlers
    {'k' => method(:up),
      'h' => method(:left),
      'j' => method(:down),
      'l' => method(:right),
      'D' => method(:toggle_debug),
      'q' => method(:quit)}
  end

  def quit
    $game.pop_page
  end
  def draw()
    super
    endx = [@view_x + @view_width, WORLD_WIDTH-1].min
    endy = [@view_y + @view_height, WORLD_HEIGHT-1].min

    draw_x = 0
    draw_y = 0 
    (@view_y..endy).each do |y|
      draw_x = 0
      (@view_x..endx).each do |x|
        cell = @world.get_cell(x, y)
        draw_cell(cell, draw_x, draw_y)
        draw_x += 1 
      end
      draw_y += 1
    end

    @window.refresh

    if @debug_box
      draw_debug_box
    end
  end

  def draw_debug_box()
      @debug_box.clear
      u_x, u_y = u_position
      @debug_box.mvaddstr 0, 0, "u are here:  #{u_x.to_s}, #{u_y.to_s}"
      s = sprintf "cell height: %.4f", @world.get_cell(u_x, u_y).height
      @debug_box.mvaddstr(1, 0, s)
      @debug_box.refresh
  end

  def set_color(color)
    @window.color_set(color, nil)
  end

  def draw_cell(cell, x, y)

    if cell.entities.length > 0
      $game.log.info 'entities at ' + x.to_s + ',' + y.to_s
      @window.color_set(Palette::WHITE_ON_BLACK, nil)
      @window.mvaddstr(y, x, '@')
      return
    end

    ch = ' '
    if cell.height <= 0.1
      set_color Palette::WHITE_ON_BLUE
      ch = '~'
    elsif cell.height < 0.2
      set_color Palette::GREEN_ON_BLUE
      ch = ' '
    elsif cell.height < 0.3
      set_color Palette::GREEN_ON_BLUE
      ch = ' '
    elsif cell.height < 0.4
      set_color Palette::CYAN_ON_YELLOW
      ch = '#'
    elsif cell.height < 0.5
      set_color Palette::GREEN_ON_YELLOW
      ch = '%'
    elsif cell.height < 0.6
      set_color Palette::CYAN_ON_GREEN
      ch = 'v'
    elsif cell.height < 0.7
      set_color Palette::WHITE_ON_CYAN
      ch = '"'
    elsif cell.height < 0.8
      set_color Palette::CYAN_ON_WHITE
      ch = "#"
    elsif cell.height < 0.9
      set_color Palette::CYAN_ON_WHITE
      ch = '*'
    else
      set_color Palette::CYAN_ON_WHITE
      ch = '*'
    end

    @window.mvaddstr y, x, ch

    $game.log.info 'cell.height=' +  cell.height.to_s
  end

  def createTiles(cell, x1, y1, x2, y2)
    #    if cell.height >= SEA_LEVEL
    #      cell.name = 'B'
    #    else
    #      cell.name = 'A'
    #    end
    #    $game.log.info cell.height
    #
    #    h = 0.7
    #    s = 1.0 - cell.height
    #    v = 1.0
    #    puts 'hsv = ', h, s, v
    #    (r, g, b) = hsv_to_rgb(h, s, v)	
    #    puts 'rbg = ', r, g, b
    #
    #    r *= 0xff
    #    g *= 0xff
    #    b *= 0xff
    #
    #    puts 'rbg = ', r, g, b
    #
    #    color = '#%02x%02x%02x' % (r, g, b)
    #
    #    id = lvl.create_rectangle(x1, y1, x2, y2,  fill=color) 
    #    ids.append(id)
    #    h = '%f' % cell.height
    #    id = lvl.create_text(x1 + 30 , y1 + 10, text=h) 
    #    ids.append(id)
    #
    #      id =  createEntityTile(cell.entities, x1, y1, x2, y2)
    #      ids.append(id)
    #    end
    #    return ids
  end

  def scrollUp() 
    @view_y = [@view_y - 25, 0].max 
  end

  def scrollDown()
    @view_y = [@view_y + 25, WORLD_HEIGHT - @view_height].min
  end

  def scrollLeft()
    @view_x = [@view_x - 80, 0].max
  end

  def scrollRight()
    @view_x = [@view_x + 80, WORLD_WIDTH - @view_width].min
  end

  def worldToView(world_x, world_y)
    x = world_x - @view_x
    y = world_y - @view_y
    return [x, y]
  end

  def u_position
    @world.findEntity(@world.u)
  end

  def move(x, y)
    if @world.isLegalMove(x, y, @world.u)
      oldx, oldy = u_position
      @world.moveEntity(x, y, @world.u)
      #draw new location
      cell = @world.get_cell x, y
      x, y = worldToView(x, y)
      draw_cell(cell, x, y)
      #redraw old location
      cell = @world.get_cell oldx, oldy
      $game.log.info 'move: ' + oldx.to_s + ' ' +  oldy.to_s + ' ' + cell.entities.length.to_s
      oldx, oldy = worldToView(oldx, oldy)
      draw_cell(cell, oldx, oldy)
      draw_debug_box if @debug_box
    end

    endTurn
  end

  def up()
    x, y = u_position
    y -= 1
    move(x, y)
  end

  def down()
    x, y = u_position
    y += 1
    move(x, y)
  end

  def left()
    x, y = u_position
    x -= 1
    move(x, y)
  end

  def right()
    x, y = u_position
    x += 1
    move(x, y)
  end

  def beginTurn()
    $game.log.info 'beginning turn'
  end

  def endTurn()
    $game.log.info 'ending turn'
    updateScroll()
    x, y = u_position
    x, y = worldToView x, y
    @window.move y,x
  end

  def updateScroll()
    u_x, u_y = u_position
    x, y = worldToView(u_x, u_y)

    do_redraw = false
    if x == 0
      scrollLeft()
      do_redraw = true
    elsif x == @view_width 
      scrollRight()
      do_redraw = true
    end
    if y == 0
      scrollUp()
      do_redraw = true
    elsif y == @view_height
      scrollDown()
      do_redraw = true
    end

    if do_redraw
      draw
      $game.redraw
    end
  end

  def toggle_debug
    if not @debug_box
      @debug_box = Ncurses.newwin 7, 24, 1, 55
      draw_debug_box 
    else
      @debug_box.delwin
      @debug_box = nil
      $game.redraw
    end
  end

end
