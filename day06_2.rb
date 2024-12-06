class Lab
  attr_reader :data, :obstacle_position

  FREE = "."
  OBSTACLE = "#"

  def initialize(data, obstacle_position = nil)
    @data = data
    @obstacle_position = obstacle_position
  end

  def obstacle?(position)
    x, y = position
    data.dig(y, x) == OBSTACLE || position == obstacle_position
  end

  def outside?(position)
    x, y = position
    x < 0 || x >= width || y < 0 || y >= height
  end

  def width
    data.first.length
  end

  def height
    data.length
  end
end

class Guard
  attr_reader :x, :y, :dx, :dy, :visited

  UP = [0, -1]
  DOWN = [0, 1]
  LEFT = [-1, 0]
  RIGHT = [1, 0]

  def initialize(initial_position)
    @x, @y = initial_position
    @dx, @dy = UP
    @visited = Set.new([[x, y, dx, dy]])
  end

  def turn_right
    @dx, @dy = case [dx, dy]
    when LEFT
      UP
    when UP
      RIGHT
    when RIGHT
      DOWN
    when DOWN
      LEFT
    else
      UP
    end
  end

  def position
    [x, y]
  end

  def next_position
    [x + dx, y + dy]
  end

  def move
    @x += dx
    @y += dy
    visited << state
  end

  def looped?
    visited.include?([x + dx, y + dy, dx, dy])
  end

  def state
    [x, y, dx, dy]
  end
end

def for_each_possible_obstacle_position(data, initial_position)
  original = Lab.new(data)
  yield original

  (0...original.width).each do |x|
    (0...original.height).each do |y|
      obstacle_position = [x, y]
      yield Lab.new(data, obstacle_position) unless original.obstacle?(obstacle_position) || obstacle_position == initial_position
    end
  end
end

data = File.read("./day06_data.txt").split("\n").map(&:chars)
# data = File.read("./day06_test_data.txt").split("\n").map(&:chars)

initial_y = data.find_index { _1.include? "^" }
initial_x = data[initial_y].find_index { _1 == "^" }
initial_position = [initial_x, initial_y]

looping_obstacles_count = 0

for_each_possible_obstacle_position(data, initial_position) do |lab|
  guard = Guard.new(initial_position)

  loop do
    break if lab.outside?(guard.next_position)

    if lab.obstacle?(guard.next_position)
      guard.turn_right
    else
      if guard.looped?
        looping_obstacles_count += 1
        break
      end

      guard.move
    end
  end
end

puts looping_obstacles_count
