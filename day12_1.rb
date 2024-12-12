$data = File.read("day12_data.txt").split("\n").map(&:chars)

$width = $data.first.length
$height = $data.length

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
  processed << [x, y]
  region << [x, y]

  neighbors(x, y).each do |_x, _y|
    find_region(_x, _y, region, processed) if $data[_y][_x] == $data[y][x]
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

cost = regions.sum do |region|
  perimeter_length = region.sum do |x, y|
    cells = neighbors(x, y)
    4 - cells.count + cells.count { |_x, _y| $data[y][x] != $data[_y][_x] }
  end

  perimeter_length * region.count
end

puts cost
