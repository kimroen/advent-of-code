require 'position'

class Trip
  attr_reader :current_position
  attr_reader :current_heading
  attr_accessor :first_visited_twice

  def initialize(initial_position = Position.new)
    @current_position = initial_position
    @current_heading = :north
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
      apply_heading(direction)
    when Numeric
      apply_steps(direction)
    end
  end

  def apply_heading(direction)
    self.current_heading =
      if direction == :left
        move_heading_left
      else
        move_heading_right
      end
  end

  def apply_steps(steps)
    steps.times do
      walk_one_block
    end
  end

  def walk_one_block
    self.current_position =
      current_position.walk(current_heading)
  end

  def move_heading_left
    case current_heading
    when :north then :west
    when :west then :south
    when :south then :east
    when :east then :north
    end
  end

  def move_heading_right
    case current_heading
    when :north then :east
    when :west then :north
    when :south then :west
    when :east then :south
    end
  end

  private

  attr_writer :current_heading
  attr_writer :current_position
end
