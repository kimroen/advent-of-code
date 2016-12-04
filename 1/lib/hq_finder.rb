require_relative 'trip'

class HqFinder
  attr_reader :trip
  attr_accessor :first_visited_twice

  def self.preview_trip(directions_string)
    new.preview_trip(directions_string)
  end

  def initialize
    @trip = Trip.new
  end

  def preview_trip(directions_string)
    directions = convert_to_directions(directions_string)

    visited_positions = []

    directions.each do |direction|
      trip.move(direction)
      current_position = trip.current_position
      next unless first_visited_twice.nil?

      if visited_positions.include? current_position
        self.first_visited_twice = current_position
      else
        visited_positions << current_position
      end
    end

    self
  end

  def last_position
    trip.current_position
  end

  def convert_to_directions(directions_string)
    directions_string
      .split(', ')
      .map do |direction_string|
        convert_to_direction(direction_string)
      end
      .flatten
  end

  # Takes a single direction and converts it into a direction array
  # For example, 'R2' turns in to `[:right, 2]`
  def convert_to_direction(direction_string)
    direction_character = direction_string[0]
    steps_string = direction_string[1..-1]
    direction = character_to_symbol(direction_character)
    [direction, steps_string.to_i]
  end

  def character_to_symbol(character)
    case character
    when 'R' then :right
    when 'L' then :left
    end
  end
end
