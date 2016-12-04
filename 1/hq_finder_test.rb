gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require_relative 'hq_finder'

class HqFinderTest < Minitest::Test
  def test_it_can_convert_string_to_directions
    directions = HqFinder.new.convert_to_directions('R2, L3')
    assert_equal [:right, 2, :left, 3], directions
  end

  def test_it_can_convert_string_to_direction
    direction = HqFinder.new.convert_to_direction('L62')
    assert_equal([:left, 62], direction)
  end

  def test_it_finds_distance
    trip = HqFinder.preview_trip('R2, L3')
    assert_equal 5, trip.last_position.blocks_away
  end

  def test_it_finds_another_distance
    trip = HqFinder.preview_trip('R2, R2, R2')
    assert_equal 2, trip.last_position.blocks_away
  end

  def test_it_finds_a_third_distance
    trip = HqFinder.preview_trip('R5, L5, R5, R3')
    assert_equal 12, trip.last_position.blocks_away
  end

  def test_it_provides_the_location_first_visited_twice
    trip = HqFinder.preview_trip('R8, R4, R4, R8')
    assert_equal 4, trip.first_visited_twice.blocks_away
  end
end

class TracerTest < Minitest::Test
  def test_it_starts_pointing_north
    assert_equal :north, Tracer.new.current_heading
  end

  def test_it_can_rotate_left
    tracer = Tracer.new
    tracer.apply_heading(:left)
    tracer.apply_heading(:left)
    assert_equal :south, tracer.current_heading
  end

  def test_it_can_rotate_right
    tracer = Tracer.new
    tracer.apply_heading(:right)
    tracer.apply_heading(:right)
    assert_equal :south, tracer.current_heading
  end

  def test_it_can_move_north
    tracer = Tracer.new
    tracer.apply_steps(4)
    assert_equal({ x: 0, y: 4 }, tracer.current_position)
  end

  def test_it_can_move_west
    tracer = Tracer.new
    tracer.apply_heading(:left)
    tracer.apply_steps(4)
    assert_equal({ x: -4, y: 0 }, tracer.current_position)
  end

  def test_it_can_move_south
    tracer = Tracer.new
    tracer.apply_heading(:right)
    tracer.apply_heading(:right)
    tracer.apply_steps(4)
    assert_equal({ x: 0, y: -4 }, tracer.current_position)
  end

  def test_it_can_move_east
    tracer = Tracer.new
    tracer.apply_heading(:right)
    tracer.apply_steps(4)
    assert_equal({ x: 4, y: 0 }, tracer.current_position)
  end

  def test_it_can_move_steps
    tracer = Tracer.new
    tracer.move(2)
    assert_equal({ x: 0, y: 2 }, tracer.current_position)
    assert_equal :north, tracer.current_heading
  end

  def test_it_can_move_rotation_left
    tracer = Tracer.new
    tracer.move(:left)
    assert_equal({ x: 0, y: 0 }, tracer.current_position)
    assert_equal :west, tracer.current_heading
  end
end
