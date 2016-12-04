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

  def last_position
    trip.current_position.distance_to_origin
  end

  def first_visited_twice
    # Somehow get the place first visited twice from the trip
    trip.first_visited_twice.distance_to_origin
  end
end
