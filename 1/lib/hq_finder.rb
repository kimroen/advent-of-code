require_relative 'trip'
require_relative 'direction_parser'

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
    directions = DirectionParser.new(directions_string).parse

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
end
