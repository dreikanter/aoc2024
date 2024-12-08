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
  next if locations.length < 2

  locations.combination(2).each do |(x1, y1), (x2, y2)|
    dx = x1 - x2
    dy = y1 - y2

    [1, -1].each do |direction|
      multiplier = 0

      loop do
        antinode = [x1 + dx * multiplier, y1 + dy * multiplier]
        break unless within_boundaries.call(*antinode)
        antinodes << antinode
        multiplier += direction
      end
    end
  end
end

puts antinodes.count
