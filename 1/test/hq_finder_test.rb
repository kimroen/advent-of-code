gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require 'hq_finder'

class HqFinderTest < Minitest::Test
  def test_it_finds_distance
    trip = HqFinder.preview_trip('R2, L3')
    assert_equal 5, trip.last_position.distance_to_origin
  end

  def test_it_finds_another_distance
    trip = HqFinder.preview_trip('R2, R2, R2')
    assert_equal 2, trip.last_position.distance_to_origin
  end

  def test_it_finds_a_third_distance
    trip = HqFinder.preview_trip('R5, L5, R5, R3')
    assert_equal 12, trip.last_position.distance_to_origin
  end

  def test_it_provides_the_location_first_visited_twice
    trip = HqFinder.preview_trip('R8, R4, R4, R8')
    assert_equal 4, trip.first_visited_twice.distance_to_origin
  end
end
