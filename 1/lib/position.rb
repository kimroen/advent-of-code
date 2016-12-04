class Position
  attr_reader :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end

  def coordinates
    { x: x, y: y }
  end

  def walk(_direction)
    self.y += 1
  end

  private

  attr_writer :x, :y
end
