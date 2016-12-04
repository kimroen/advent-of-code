require_relative 'position'

class Trip
  attr_reader :current_position
  attr_reader :current_bearing
  attr_accessor :first_visited_twice

  def initialize(initial_position = Position.new)
    @current_position = initial_position
    @current_bearing = :north
  end

  def simulate(directions)
    visited_positions = []

    directions.each do |direction|
      move(direction)
      next unless first_visited_twice.nil?

      if visited_positions.include? current_position
        self.first_visited_twice = current_position
      else
        visited_positions << current_position
      end
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
      apply_steps(direction)
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

  def apply_steps(steps)
    steps.times do
      walk_one_block
    end
  end

  def walk_one_block
    self.current_position =
      current_position.walk(current_bearing)
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

  private

  attr_writer :current_bearing
  attr_writer :current_position
end
