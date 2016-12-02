class Tracer
  attr_reader :current_position
  attr_reader :current_heading

  def initialize(initial_position = { x: 0, y: 0 })
    @current_position = initial_position
    @current_heading = :north
  end

  def blocks_away
    current_position[:x].abs + current_position[:y].abs
  end

  def move(direction)
    apply_heading(direction[:direction])
    apply_steps(direction[:steps])
  end

  def apply_heading(direction)
    self.current_heading =
      if direction == :left
        move_heading_left
      else
        move_heading_right
      end
  end

  def apply_steps(steps)
    case current_heading
    when :north
      current_position[:y] += steps
    when :west
      current_position[:x] -= steps
    when :south
      current_position[:y] -= steps
    when :east
      current_position[:x] += steps
    end
  end

  def move_heading_left
    case current_heading
    when :north then :west
    when :west then :south
    when :south then :east
    when :east then :north
    end
  end

  def move_heading_right
    case current_heading
    when :north then :east
    when :west then :north
    when :south then :west
    when :east then :south
    end
  end

  private

  attr_writer :current_heading
end
