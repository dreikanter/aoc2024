map = File.read("day10_data.txt").split("\n").map { _1.chars.map(&:to_i) }

STEPS = [[0, 1], [0, -1], [1, 0], [-1, 0]]

def track(map, x, y, score = Set.new)
  return score if x < 0 || y < 0
  return score << [x, y] if map[y][x] == 9

  next_step = map[y][x] + 1

  STEPS.each do |step_x, step_y|
    next unless map.dig(y + step_y, x + step_x) == next_step
    score = track(map, x + step_x, y + step_y, score)
  end

  score
end

width = map.first.length
height = map.length
result = 0

(0...height).each do |y|
  (0...width).each do |x|
    result += track(map, x, y).count if map[y][x] == 0
  end
end

puts result
