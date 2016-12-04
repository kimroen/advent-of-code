require_relative 'position'

class Trip
  attr_reader :current_bearing
  attr_reader :visited_positions
  attr_accessor :first_visited_twice

  def initialize(initial_position = Position.new)
    @current_bearing = :north
    @visited_positions = [initial_position]
  end

  def simulate(directions)
    directions.each do |direction|
      move(direction)
    end
  end

  def current_coordinates
    current_position.coordinates
  end

  def move(direction)
    case direction
    when Symbol
      turn(direction)
    when Numeric
      walk(direction)
    end
  end

  def turn(direction)
    self.current_bearing =
      if direction == :left
        turn_left
      else
        turn_right
      end
  end

  def walk(steps)
    steps.times do
      walk_one_block
    end
  end

  def walk_one_block
    self.current_position =
      current_position.walk(current_bearing)
  end

  def current_position
    visited_positions.last
  end

  private

  attr_writer :current_bearing
  attr_writer :current_position

  def current_position=(new_position)
    visited_positions << new_position
  end

  def turn_left
    case current_bearing
    when :north then :west
    when :west then :south
    when :south then :east
    when :east then :north
    end
  end

  def turn_right
    case current_bearing
    when :north then :east
    when :west then :north
    when :south then :west
    when :east then :south
    end
  end
end
