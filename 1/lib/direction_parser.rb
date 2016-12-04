class DirectionParser
  def initialize(directions_string)
    @directions_string = directions_string
  end

  def parse
    directions_string
      .split(', ')
      .map do |direction_string|
        parse_single_direction(direction_string)
      end
      .flatten
  end

  private

  attr_reader :directions_string

  # Takes a single direction and converts it into a direction array
  # For example, 'R2' turns in to `[:right, 2]`
  def parse_single_direction(direction_string)
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
