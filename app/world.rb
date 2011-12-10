WORLD_WIDTH=256
WORLD_HEIGHT=WORLD_WIDTH
SEA_LEVEL = 0.5

class Cell
  attr_accessor :name, :height, :entities
  def initialize
    @name = ''
    @height = 0.0
    @entities = []
  end
end


class World
  attr_accessor :world_data, :u
  def get_cell(x, y)
    @world_data[x][y]
  end

  def addEntity(x, y, entity)
    return if @entityIndex.has_key?(entity)
    cell = @world_data[x][y]
    @world_data[x][y].entities.push(entity)
    @entityIndex[entity] = [x, y]
  end

  def removeEntity(x, y, entity)
    @world_data[x][y].entities.delete(entity)
    @entityIndex.delete(entity)
  end

  def moveEntity(x, y, entity)
    (oldx, oldy) = findEntity(entity)
    removeEntity(oldx, oldy, entity)
    addEntity(x, y, entity)
    triggerEvents(x, y, entity)
  end

  def triggerEvents(x, y, entity)
    #printf '%s moved to %d %d',  entity.name, x, y
  end

  def findEntity(entity)
    @entityIndex[entity]
  end

  def random()
    if @use_rand
      rand
    else
      @randoms.shift
    end
  end

  def initialize
    f = open('random_numbers.txt')
    @randoms = []
    f.each {|i| @randoms.push i.to_f} 
    @use_rand = true

    @entityIndex = {}
    @u = nil
    _createWorld()
  end

  def isLegalMove(x, y, entity)
    if x < 0 or x >= WORLD_WIDTH or y < 0 or y >= WORLD_WIDTH:
      return false
    end
    true
  end


  def _createWorld()
    start_time = Time.now
    @world_data = []
    WORLD_WIDTH.times do |x|
      data = []
      WORLD_HEIGHT.times do |y|
        cell = Cell.new
        cell.name = 'A'
        data.push(cell)
      end
      @world_data.push(data)
    end

    _createSeafloor()

    @u = Entity.new
    @u.npc = false
    @u.name="player"
    addEntity(5, 5, @u)
    $game.log.info "world gen took #{(Time.now - start_time)} secs..."
    #_saveBitmap()
  end


  def _square(x1, y1, x2, y2, rangeMin, rangeMax)

    stride = x2 - x1
    half_stride = stride/2	

    start_points = [
      [x1, y1],
      [x1 + half_stride, y1 + half_stride],
      [x1, y2],
      [x1 - half_stride, y1 + half_stride]
    ]

    start_points.each do |start|
      #height_values = [0] * 4
      height_values = []
      x = start[0]
      y = start[1]

      if x >= 0
        height_values.push @world_data[x][y].height
      end

      x = start[0] + half_stride
      y = start[1] - half_stride

      if y >= 0
        height_values.push @world_data[x][y].height
      end

      x = start[0] + stride
      y = start[1] 

      if x < WORLD_WIDTH	
        height_values.push @world_data[x][y].height
      end

      x = start[0] + half_stride
      y = start[1] + half_stride

      if y < WORLD_HEIGHT
        height_values.push @world_data[x][y].height
      end
      sum = 0
      height_values.each {|value| sum += value}
      average_height = sum.to_f/height_values.length
      x = start[0] + half_stride
      y = start[1]
      r = rangeMin + random() * (rangeMax - rangeMin)
      height = average_height + r
      @world_data[x][y].height = height
      @world_data[x][y].name = 'B'
    end
  end


  def _diamond(x1, y1, x2, y2, rangeMin, rangeMax)

    avg = (
      @world_data[x1][y1].height +
      @world_data[x2][y1].height +
      @world_data[x1][y2].height +
      @world_data[x2][y2].height 
    )/4.0

    # find center and set its height
    cx = x1 + (x2 - x1)/2
    cy = y1 + (y2 - y1)/2

    @world_data[cx][cy].name = 'B'
    r = rangeMin +  random() * (rangeMax - rangeMin)
    height = avg + r
    @world_data[cx][cy].height = height
  end


  def _createSeafloor()
    ''' creates sea floor as well as islands etc '''
    roughness = 0.6

    rangeMax = 1.0
    rangeMin = -1.0
    w = WORLD_WIDTH
    h = WORLD_HEIGHT
    x1 = 0
    y1 = 0
    x2 = w - 1
    y2 = h - 1 

    range = rangeMax - rangeMin
    # assign corners of world some random heighs from min to max
    @world_data[x1][y1].height = rangeMin + random * rangeMax 
    @world_data[x2][y1].height = rangeMin + random * rangeMax 
    @world_data[x1][y2].height = rangeMin + random * rangeMax 
    @world_data[x2][y2].height = rangeMin + random * rangeMax 

    stride = WORLD_WIDTH
    done = false	

    while stride > 1
      while y2 < WORLD_HEIGHT
        while x2 < WORLD_WIDTH
          _diamond(x1, y1, x2, y2, rangeMin, rangeMax)
          _square(x1, y1, x2, y2, rangeMin, rangeMax)
          x1 += stride
          x2 += stride
        end
        x1 = 0
        x2 = stride
        y1 += stride
        y2 += stride
      end

      stride /= 2 
      x1 = y1 = 0
      x2 = y2 = stride
      newRange = (rangeMax - rangeMin) * (2 ** -roughness)
      halfNewRange = newRange/2	

      rangeMin = -halfNewRange
      rangeMax = halfNewRange
    end
    _normalize()
    #_erode()
    dump('cell_height')
  end

  def dump(name)
    WORLD_HEIGHT.times do |y|
      WORLD_WIDTH.times do |x|
        $game.log.info name + ':' + (y * WORLD_WIDTH + x).to_s + ',' + @world_data[x][y].height.to_s
      end
    end
  end

  def _normalize()

    max = 0.0
    min = nil
    sum = 0.0
    avg = 0.0

    WORLD_HEIGHT.times do |y|
      WORLD_WIDTH.times do |x|
        cell = @world_data[x][y]
        if cell.height > max
          max = cell.height
        end
        if not min or cell.height < min
          min = cell.height
        end

        sum += cell.height
      end
    end

    @avg = sum.to_f/(WORLD_WIDTH * WORLD_HEIGHT)	
    span = max - min
    WORLD_HEIGHT.times do |y|
      WORLD_WIDTH.times do |x|
        h = @world_data[x][y].height - min
        h /= span
        @world_data[x][y].height = h
      end
    end
  end

  def _erode()
    WORLD_HEIGHT.times do |y|
      WORLD_WIDTH.times do |x|
        lonely = true
        if x > 0 and @world_data[x-1][y].height > SEA_LEVEL
          lonely = false
        end
        if lonely and x < WORLD_WIDTH-1 and @world_data[x+1][y].height > SEA_LEVEL
          lonely = false
        end
        if lonely and y > 0 and @world_data[x][y-1].height > SEA_LEVEL
          lonely = false
        end
        if lonely and y < WORLD_HEIGHT-1 and @world_data[x][y+1].height > SEA_LEVEL
          lonely = false
        end

        if lonely
          @world_data[x][y].height = 0.0
        end
      end
    end
  end

  #    def _saveBitmap()
  #      image_data = ''
  #      h = 0.7
  #      v = 1.0
  #
  #
  #      WORLD_HEIGHT.times do |y|
  #        image_data += '{'
  #
  #        WORLD_WIDTH.times do |x|
  #          s = 1.0 - @world_data[x][y].height
  #          (r,g,b) = hsv_to_rgb(h, s, v)
  #          r *= 0xff
  #          g *= 0xff
  #          b *= 0xff
  #          color = '#%02x%02x%02x ' % (r, g, b)
  #          print color
  #
  #          image_data += color
  #        end
  #
  #        image_data += '} '
  #      end
  #
  #      pi = PhotoImage()
  #      pi.put(image_data)
  #      pi.write('map.ppm')
  #    end
end

