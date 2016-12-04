gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require 'tracer'

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

  def test_it_can_walk_multiple_steps
    tracer = Tracer.new
    tracer.apply_steps(5)
    assert_equal({ x: 0, y: 5 }, tracer.current_position)
  end

  def test_it_can_move_north
    tracer = Tracer.new
    tracer.walk_one_block
    assert_equal({ x: 0, y: 1 }, tracer.current_position)
  end

  def test_it_can_move_west
    tracer = Tracer.new
    tracer.apply_heading(:left)
    tracer.walk_one_block
    assert_equal({ x: -1, y: 0 }, tracer.current_position)
  end

  def test_it_can_move_south
    tracer = Tracer.new
    tracer.apply_heading(:right)
    tracer.apply_heading(:right)
    tracer.walk_one_block
    assert_equal({ x: 0, y: -1 }, tracer.current_position)
  end

  def test_it_can_move_east
    tracer = Tracer.new
    tracer.apply_heading(:right)
    tracer.walk_one_block
    assert_equal({ x: 1, y: 0 }, tracer.current_position)
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
