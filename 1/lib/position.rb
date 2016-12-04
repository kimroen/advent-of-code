class Position
  attr_reader :x, :y

  def initialize
    @x = 0
    @y = 0
  end

  def coordinates
    { x: x, y: y }
  end
end
