gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require 'trip'

class TripTest < Minitest::Test
  def test_it_starts_pointing_north
    assert_equal :north, Trip.new.current_bearing
  end

  def test_it_can_turn_left
    trip = Trip.new
    trip.turn(:left)
    trip.turn(:left)
    assert_equal :south, trip.current_bearing
  end

  def test_it_can_turn_right
    trip = Trip.new
    trip.turn(:right)
    trip.turn(:right)
    assert_equal :south, trip.current_bearing
  end

  def test_it_can_walk_multiple_steps
    trip = Trip.new
    trip.apply_steps(5)
    assert_equal({ x: 0, y: 5 }, trip.current_coordinates)
  end

  def test_it_can_move_north
    trip = Trip.new
    trip.walk_one_block
    assert_equal({ x: 0, y: 1 }, trip.current_coordinates)
  end

  def test_it_can_move_west
    trip = Trip.new
    trip.turn(:left)
    trip.walk_one_block
    assert_equal({ x: -1, y: 0 }, trip.current_coordinates)
  end

  def test_it_can_move_south
    trip = Trip.new
    trip.turn(:right)
    trip.turn(:right)
    trip.walk_one_block
    assert_equal({ x: 0, y: -1 }, trip.current_coordinates)
  end

  def test_it_can_move_east
    trip = Trip.new
    trip.turn(:right)
    trip.walk_one_block
    assert_equal({ x: 1, y: 0 }, trip.current_coordinates)
  end

  def test_it_can_move_steps
    trip = Trip.new
    trip.move(2)
    assert_equal({ x: 0, y: 2 }, trip.current_coordinates)
    assert_equal :north, trip.current_bearing
  end

  def test_it_can_move_rotation_left
    trip = Trip.new
    trip.move(:left)
    assert_equal({ x: 0, y: 0 }, trip.current_coordinates)
    assert_equal :west, trip.current_bearing
  end

  def test_it_exposes_its_current_coordinates
    trip = Trip.new
    expected_coordinates = { x: 0, y: 0 }
    assert_equal expected_coordinates, trip.current_coordinates
  end
end
