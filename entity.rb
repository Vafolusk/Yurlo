class Entity
  attr_accessor :name, :level, :speed, :className, :npc
  def initialize()
    @name = 'unknown'
    @level = -1	
    @speed = 0
    @className = 'unidentifiable' 
    @npc = true
  end

  def move(x, y)
    if @speed == 0:
      return
    end
  end
end
