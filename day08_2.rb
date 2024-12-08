map = File.read("day08_data.txt").split("\n").map(&:chars)

width = map.first.length
height = map.length

antennas = {}

(0...width).each do |x|
  (0...height).each do |y|
    frequency = map[y][x]
    next if frequency == "."
    (antennas[frequency] ||= []) << [x, y]
  end
end

within_boundaries = -> (x, y) { !x.negative? && !y.negative? && x < width && y < height }
antinodes = Set.new

antennas.each do |frequency, locations|
  next if locations.length < 2

  locations.combination(2).each do |antenna1, antenna2|
    offset_x = antenna1[0] - antenna2[0]
    offset_y = antenna1[1] - antenna2[1]

    [[offset_x, offset_y], [-offset_x, -offset_y]].each do |dx, dy|
      multiplier = 0

      loop do
        antinode = [antenna1[0] + dx * multiplier, antenna1[1] + dy * multiplier]
        break unless within_boundaries.call(*antinode)
        antinodes << antinode
        multiplier += 1
      end
    end
  end
end

puts antinodes.count
