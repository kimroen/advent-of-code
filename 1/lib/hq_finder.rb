require_relative 'trip'
require_relative 'direction_parser'

class HqFinder
  attr_reader :trip

  def initialize
    @trip = Trip.new
  end

  def simulate_trip(directions_string)
    directions = DirectionParser.new(directions_string).parse
    trip.simulate(directions)
  end

  def last_position_distance
    trip.current_position.distance_to_origin
  end

  def first_visited_twice_distance
    checked_positions = []

    trip.visited_positions.each do |position|
      if checked_positions.include? position
        return position.distance_to_origin
      else
        checked_positions << position
      end
    end
  end
end
