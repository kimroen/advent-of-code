class Position
  attr_accessor :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end

  def coordinates
    { x: x, y: y }
  end

  def walk(direction)
    new_position = Position.new(coordinates)

    case direction
    when :north
      new_position.y += 1
    when :south
      new_position.y -= 1
    when :east
      new_position.x += 1
    when :west
      new_position.x -= 1
    end

    new_position
  end

  def distance_to(other_position)
    y_distance = other_position.y - y
    x_distance = other_position.x - x

    x_distance.abs + y_distance.abs
  end

  def distance_to_origin
    distance_to(Position.new)
  end
end
