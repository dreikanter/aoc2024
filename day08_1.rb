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
  locations.combination(2).each do |antenna1, antenna2|
    x1, y1 = antenna1
    x2, y2 = antenna2

    dx = x1 - x2
    dy = y1 - y2

    antinodes +=  [
      [x1 + dx, y1 + dy],
      [x1 - dx, y1 - dy],
      [x2 + dx, y2 + dy],
      [x2 - dx, y2 - dy]
    ].filter { antenna1 != _1 && antenna2 != _1 && within_boundaries.call(*_1) }
  end
end

puts antinodes.count
