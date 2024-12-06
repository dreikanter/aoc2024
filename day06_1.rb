class Lab
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def obstacle?(x, y)
    data.dig(y, x) == "#"
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
  attr_reader :x, :y, :dx, :dy, :distinct_positions

  UP = [0, -1]
  DOWN = [0, 1]
  LEFT = [-1, 0]
  RIGHT = [1, 0]

  def initialize(x, y)
    @x = x
    @y = y
    @dx, @dy = UP
    @distinct_positions = Set.new([[x, y]])
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
  end
end

data = File.read("./day06_data.txt").split("\n").map(&:chars)

initial_y = data.find_index { _1.include? "^" }
initial_x = data[initial_y].find_index { _1 == "^" }

guard = Guard.new(initial_x, initial_y)
lab = Lab.new(data)

loop do
  break if lab.outside?(*guard.next_position)

  if lab.obstacle?(*guard.next_position)
    guard.turn_right
  else
    guard.move
  end
end

puts guard.distinct_positions.count
