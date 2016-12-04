class Position
  attr_reader :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end

  def coordinates
    { x: x, y: y }
  end

  def walk(direction)
    case direction
    when :north
      self.y += 1
    when :south
      self.y -= 1
    when :east
      self.x += 1
    when :west
      self.x -= 1
    end
  end

  private

  attr_writer :x, :y
end
