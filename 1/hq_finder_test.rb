gem 'minitest', '>=5'

require 'minitest/autorun'
require 'minitest/pride'

require_relative 'hq_finder'

class HqFinderTest < Minitest::Test
  def test_it_can_convert_string_to_directions
    directions = HqFinder.new.convert_to_directions('R2, L3')
    assert_equal [
      { direction: :right, steps: 2 },
      { direction: :left, steps: 3 }
    ], directions
  end

  def test_it_can_convert_string_to_direction
    direction = HqFinder.new.convert_to_direction('L62')
    assert_equal({ direction: :left, steps: 62 }, direction)
  end

  def test_it_finds_distance
    finder = HqFinder.find('R2, L3')
    assert_equal 5, finder.blocks_away
  end

  def test_it_finds_another_distance
    finder = HqFinder.find('R2, R2, R2')
    assert_equal 2, finder.blocks_away
  end

  def test_it_finds_a_third_distance
    finder = HqFinder.find('R5, L5, R5, R3')
    assert_equal 12, finder.blocks_away
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

  def test_moving_once
    tracer = Tracer.new
    tracer.move(direction: :left, steps: 20)
    assert_equal({ x: -20, y: 0 }, tracer.current_position)
  end

  def test_moving_twice
    tracer = Tracer.new
    tracer.move(direction: :right, steps: 15)
    tracer.move(direction: :left, steps: 2)
    assert_equal({ x: 15, y: 2 }, tracer.current_position)
  end
end
