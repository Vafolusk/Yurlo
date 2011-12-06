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
    @objects = []

    @debug_box = Page.new nil
    @debug_box.bbox = {:x => 55,:y => 1, :width => 24, :height => 7}
    @debug_box.border = true
    @debug_show = false
  end

  def key_handlers
    {'k' => method(:up),
      'h' => method(:left),
      'j' => method(:down),
      'l' => method(:right),
      'D' => method(:toggle_debug),
      'b' => method(:blather),
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

    if @debug_show
      draw_debug_box
    end
  end

  def draw_debug_box()
      @debug_box.draw 
      x = @debug_box.bbox[:x] + 2
      y = @debug_box.bbox[:y] + 2

      Term.set_cursor_pos x, y
      u_x, u_y = u_position
      printf "u are here:  %d, %d", u_x, u_y
      Term.set_cursor_pos x, y + 1
      printf "cell height: %.4f", @world.get_cell(u_x, u_y).height
      x, y = worldToView(u_x, u_y)
      Term.set_cursor_pos x, y
  end

  def draw_cell(cell, x, y)

    if cell.entities.length > 0
      $game.log.info 'entities at ' + x.to_s + ',' + y.to_s
      Term.set_display_attributes [Term::FG_WHITE, Term::BG_BLACK]
      Term.set_cursor_pos x, y
      printf '@'
      return
    end

    Term.set_cursor_pos x, y
    ch = ' '
    if cell.height <= 0.1
      Term.set_display_attributes [Term::FG_WHITE, Term::BG_BLUE]
      ch = '~'
    elsif cell.height < 0.2
      Term.set_display_attributes [Term::FG_GREEN, Term::BG_BLUE]
      ch = ' '
    elsif cell.height < 0.3
      Term.set_display_attributes [Term::FG_GREEN, Term::BG_BLUE]
      ch = ' '
    elsif cell.height < 0.4
      Term.set_display_attributes [Term::FG_CYAN, Term::BG_YELLOW]
      ch = '#'
    elsif cell.height < 0.5
      Term.set_display_attributes [Term::BG_GREEN, Term::FG_YELLOW]
      ch = '%'
    elsif cell.height < 0.6
      Term.set_display_attributes [Term::FG_CYAN, Term::BG_GREEN]
      ch = 'v'
    elsif cell.height < 0.7
      Term.set_display_attributes [Term::FG_WHITE, Term::BG_CYAN]
      ch = '"'
    elsif cell.height < 0.8
      Term.set_display_attributes [Term::BG_WHITE, Term::FG_CYAN]
      ch = "#"
    elsif cell.height < 0.9
      Term.set_display_attributes [Term::BG_WHITE, Term::FG_CYAN]
      ch = '*'
    else
      Term.set_display_attributes [Term::BG_WHITE, Term::FG_CYAN]
      ch = '*'
    end

    printf ch 

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
      if @debug_show
        draw_debug_box
      end
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
    Term.set_cursor_pos x, y
  end

  def updateScroll()
    u_x, u_y = u_position
    x, y = worldToView(u_x, u_y)

    do_redraw = false
    if x == 0
      scrollLeft()
      do_redraw = true
    elsif x == @view_width + 1
      scrollRight()
      do_redraw = true
    end
    if y == 0
      scrollUp()
      do_redraw = true
    elsif y == @view_height + 1
      scrollDown()
      do_redraw = true
    end

    if do_redraw
      $game.redraw
      Term.set_cursor_pos x, y
    end
  end

  def toggle_debug
    @debug_show = !@debug_show
    draw_debug_box if @debug_show
    $game.redraw unless @debug_show
  end

end
