map = File.read("day08_data.txt").split("\n").map(&:chars)

width = map.first.length
height = map.length

antennas = {}

(0...width).each do |x|
  (0...height).each do |y|
    frequency = map[y][x]
    (antennas[frequency] ||= []) << [x, y] unless frequency == "."
  end
end

within_boundaries = -> (x, y) { (0...width).include?(x) && (0...height).include?(y) }
antinodes = Set.new

antennas.each do |frequency, locations|
  locations.combination(2).each do |(x1, y1), (x2, y2)|
    antinodes +=  [[2 * x1 - x2, 2 * y1 - y2], [2 * x2 - x1, 2 * y2 - y1]].filter { within_boundaries.call(*_1) }
  end
end

puts antinodes.count
