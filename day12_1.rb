$data = File.read("day12_data.txt").split("\n").map(&:chars)

$width = $data.first.length
$height = $data.length

$visits = (0...$height).map { Array.new($width, 0) }

def neighbors(x, y)
  [
    [x - 1, y],
    [x + 1, y],
    [x, y - 1],
    [x, y + 1]
  ].filter { _1 >= 0 && _1 < $width && _2 >= 0  && _2 < $height }
end

def find_region(x, y, region, processed)
  return if processed.include?([x, y])
  plant = $data[y][x]

  $visits[y][x] += 1
  processed << [x, y]
  region << [x, y]

  neighbors = neighbors(x, y)

  neighbors.each do |_x, _y|
    find_region(_x, _y, region, processed) if $data[_y][_x] == plant
  end

  return region
end

processed = Set.new
regions = []

(0...$width).each do |x|
  (0...$height).each do |y|
    region = find_region(x, y, Set.new, processed)
    regions << region if region
  end
end

# puts
# puts "--- data ---"
# puts $data.map { |row| row.map { |key| "%3s" % key.to_s }.join }.join("\n")
#
# puts
# puts "--- map ---"
# map = (0...$height).map { Array.new($width, 0) }
# regions.each_with_index do |region, index|
#   region.each { map[_2][_1] = index }
# end
# puts map.map { |row| row.map { |key| "%3s" % key.to_s }.join }.join("\n")

perimeters = regions.map do |region|
  region.sum do |x, y|
    cells = neighbors(x, y)
    4 - cells.count + cells.count { |_x, _y| $data[y][x] != $data[_y][_x] }
  end
end

cost = regions.sum do |region|
  perimeter_length = region.sum do |x, y|
    cells = neighbors(x, y)
    4 - cells.count + cells.count { |_x, _y| $data[y][x] != $data[_y][_x] }
  end

  # puts "#{region.count} * #{perimeter_length} == #{perimeter_length * region.count}"
  perimeter_length * region.count
end

puts cost
