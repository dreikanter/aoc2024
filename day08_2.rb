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

within_boundaries = -> (x, y) { !x.negative? && !y.negative? && x < width && y < height }
antinodes = Set.new

antennas.each do |frequency, locations|
  next if locations.length < 2

  locations.combination(2).each do |antenna1, antenna2|
    dx = antenna1[0] - antenna2[0]
    dy = antenna1[1] - antenna2[1]

    [1, -1].each do |direction|
      multiplier = 0

      loop do
        antinode = [antenna1[0] + dx * multiplier, antenna1[1] + dy * multiplier]
        break unless within_boundaries.call(*antinode)
        antinodes << antinode
        multiplier += direction
      end
    end
  end
end

puts antinodes.count
