class Lab
  attr_reader :data

  FREE = "."
  OBSTACLE = "#"
  NEW_OBSTACLE = "O"

  def initialize(data)
    @data = data
  end

  def obstacle?(x, y)
    data.dig(y, x) == OBSTACLE || data.dig(y, x) == NEW_OBSTACLE
  end

  def set_obstacle(x, y)
    data[y][x] = NEW_OBSTACLE
  end

  def remove_obstacle(x, y)
    data[y][x] = FREE
  end

  def outside?(x, y)
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
  attr_reader :x, :y, :dx, :dy, :distinct_positions, :trajectory

  UP = [0, -1]
  DOWN = [0, 1]
  LEFT = [-1, 0]
  RIGHT = [1, 0]

  def initialize(x, y)
    @x = x
    @y = y
    @dx, @dy = UP
    @distinct_positions = Set.new([[x, y]])
    @trajectory = [[x, y]]
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
    @distinct_positions << position
    @trajectory << position
  end

  def looped?
    length = trajectory.length
    return false if length < 2

    (2..length / 2).any? do |loop_length|
      (0...loop_length).all? { trajectory[length - loop_length + _1] == trajectory[length - 2 * loop_length + _1] }
    end
  end
end

def for_each_possible_obstacle_position(data, initial_x, initial_y)
  lab = Lab.new(data)
  yield lab

  (0...lab.width).each do |x|
    (0...lab.height).each do |y|
      next if lab.obstacle?(x, y) || (x == initial_x && y == initial_y)
      lab.set_obstacle(x, y)
      puts "set_obstacle #{[x, y]}"
      puts lab.data.map { _1.join }.join("\n")
      puts
      yield lab
      lab.remove_obstacle(x, y)
    end
  end
end

data = File.read("./day06_data.txt").split("\n").map(&:chars)

initial_y = data.find_index { _1.include? "^" }
initial_x = data[initial_y].find_index { _1 == "^" }

looping_obstacles_count = 0

for_each_possible_obstacle_position(data, initial_x, initial_y) do |lab|
  guard = Guard.new(initial_x, initial_y)

  loop do
    break if lab.outside?(*guard.next_position)
    break looping_obstacles_count += 1 if guard.looped?
    lab.obstacle?(*guard.next_position) ? guard.turn_right : guard.move
  end
end

puts looping_obstacles_count
