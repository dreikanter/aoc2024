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
  locations.combination(2).each do |antenna1, antenna2|
    dx = antenna1[0] - antenna2[0]
    dy = antenna1[1] - antenna2[1]

    antinodes +=  [
      [antenna1[0] + dx, antenna1[1] + dy],
      [antenna1[0] - dx, antenna1[1] - dy],
      [antenna2[0] + dx, antenna2[1] + dy],
      [antenna2[0] - dx, antenna2[1] - dy]
    ].filter { antenna1 != _1 && antenna2 != _1 && within_boundaries.call(*_1) }
  end
end

puts antinodes.count
