data = File.read("day09_data.txt").strip

total_length = 0

map = (0..data.length / 2).map do |index|
  block_length = data[index * 2].to_i
  total_length += block_length
  space_length = data[index * 2 + 1].to_i
  [index] * block_length + ["."] * space_length
end.flatten

free_offset = map.find_index { _1 == "." }

map.length.pred.downto(total_length).map do |offset|
  id = map[offset]
  next if id == "."
  map[offset] = "."
  map[free_offset] = id
  free_offset += 1 while map[free_offset] != "." && free_offset < offset
end

puts (0...total_length).sum { _1 * map[_1] }
