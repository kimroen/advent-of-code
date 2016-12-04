require_relative 'tracer'

class HqFinder
  attr_reader :tracer

  def self.find(directions_string)
    new.find(directions_string)
  end

  def initialize
    @tracer = Tracer.new
  end

  def find(directions_string)
    directions = convert_to_directions(directions_string)

    directions.each do |direction|
      tracer.move(direction)
    end

    self
  end

  def endpoint
    tracer
  end

  def convert_to_directions(directions_string)
    directions_string
      .split(', ')
      .map do |direction_string|
        convert_to_direction(direction_string)
      end
  end

  # Takes a single direction and converts it into a direction hash
  # For example, 'R2' turns in to { direction: :right, steps: 2 }
  def convert_to_direction(direction_string)
    direction_character = direction_string[0]
    steps_string = direction_string[1..-1]
    direction = character_to_symbol(direction_character)
    {
      direction: direction,
      steps: steps_string.to_i
    }
  end

  def character_to_symbol(character)
    case character
    when 'R' then :right
    when 'L' then :left
    end
  end
end
