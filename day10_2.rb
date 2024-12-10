map = File.read("day10_data.txt").split("\n").map { _1.chars.map(&:to_i) }

STEPS = [[0, 1], [0, -1], [1, 0], [-1, 0]]

def track(map, x, y, route = [[x, y]], complete_routes = Set.new)
  return complete_routes if x < 0 || y < 0
  return complete_routes << route if map[y][x] == 9

  next_step = map[y][x] + 1

  STEPS.each do |step_x, step_y|
    next unless map.dig(y + step_y, x + step_x) == next_step
    complete_routes = track(map, x + step_x, y + step_y, route + [[x + step_x, y + step_y]], complete_routes)
  end

  complete_routes
end

width = map.first.length
height = map.length
result = 0

(0...height).each do |y|
  (0...width).each do |x|
    result += track(map, x, y, [[x, y]]).count if map[y][x] == 0
  end
end

puts result
