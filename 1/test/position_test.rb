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
end
