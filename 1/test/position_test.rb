gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require 'position'

class PositionTest < Minitest::Test
  def test_it_has_coordinates
    position = Position.new

    expected_coordinates = { x: 0, y: 0 }
    assert_equal expected_coordinates, position.coordinates
    assert_equal 0, position.y
    assert_equal 0, position.x
  end

  def test_it_can_walk_north
    position = Position.new

    new_position = position.walk(:north)

    expected_coordinates = { x: 0, y: 1 }
    assert_equal expected_coordinates, new_position.coordinates
  end

  def test_it_can_walk_south
    position = Position.new

    new_position = position.walk(:south)

    expected_coordinates = { x: 0, y: -1 }
    assert_equal expected_coordinates, new_position.coordinates
  end

  def test_it_can_walk_east
    position = Position.new

    new_position = position.walk(:east)

    expected_coordinates = { x: 1, y: 0 }
    assert_equal expected_coordinates, new_position.coordinates
  end

  def test_it_can_walk_west
    position = Position.new

    new_position = position.walk(:west)

    expected_coordinates = { x: -1, y: 0 }
    assert_equal expected_coordinates, new_position.coordinates
  end

  def test_it_can_calculate_distance_to_other_position
    position = Position.new
    other_position = Position.new(x: 5, y:-2)

    result = position.distance_to(other_position)

    assert_equal 7, result
  end

  def test_it_can_calculate_distance_to_origin
    position = Position.new(x: 2, y: 4)

    result = position.distance_to_origin

    assert_equal 6, result
  end
end
