require 'world'
require 'entity'
require 'page'
require 'term'

VIEW_WIDTH=20
VIEW_HEIGHT=15

class Scroller < Page
  def initialize()
    super nil
    @world = World.new
    @view_x = 0
    @view_y = 0
    @view_width=VIEW_WIDTH
    @view_height=VIEW_HEIGHT
    @objects = []
  end

  def key_handlers
    {'w' => method(:up),
      'a' => method(:left),
      's' => method(:down),
      'd' => method(:right),
      'q' => method(:quit)}
  end

  def quit
    $game.quit
  end

  def clear_view()
    @objects.each do |id|
      # ?
    end

    @objects = []
  end

  def draw()
    super
    clear_view()
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

    if cell.height <= 0.0
      Term.set_display_attributes [Term::BG_BLUE]
    elsif cell.height <  0.4
      Term.set_display_attributes [Term::BG_GREEN, Term::DIM]
    elsif cell.height < 0.7
      Term.set_display_attributes [Term::BG_CYAN, Term::DIM]
    else
      Term.set_display_attributes [Term::BG_WHITE, Term::DIM]
    end

    printf ' '

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
    @view_y = [@view_y - 1, 0].max 
    draw()
  end

  def scrollDown()
    @view_y = [@view_y + 1, WORLD_HEIGHT - @view_height].min
    draw()
  end

  def scrollLeft()
    @view_x = [@view_x - 1, 0].max
    draw()
  end

  def scrollRight()
    @view_x = [@view_x + 1, WORLD_WIDTH - @view_width].min
    draw()
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
      @world.moveEntity(x, y, @world.u)
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
    $game.redraw
  end

  def updateScroll()
    x, y = u_position
    x, y = worldToView(x, y)
    x1 = @view_width/4
    y1 = @view_height/4
    x2 = x1 + @view_width/2
    y2 = y1 + @view_height/2

    if x < x1
      scrollLeft()
    elsif x > x2
      scrollRight()
    end
    if y < y1
        scrollUp()
    elsif y > y2
        scrollDown()
    end
  end
end
