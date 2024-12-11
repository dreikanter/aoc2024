# data = File.read("day09_data.txt").strip.chars.map(&:to_i)
data = File.read("day09_test_data.txt").strip.chars.map(&:to_i)

# [[id or ".", length], ...]
segments = (0...data.length).map { [_1.odd? ? "." : _1 / 2, data[_1]] }
# puts segments.map { |id, length| id.to_s * length }.join

segments.length.pred.downto(0).each do |file_index|
  file_id, file_length = segments[file_index]
  next if file_id == "."
  # puts
  # puts file_id.to_s * file_length

  # # slot_index = segments.find_index { _1[0] == "." && _1[1] >= file_length }
  slot_index = (0...file_index).find { segments[_1][0] == "." && segments[_1][1] >= file_length}

  next unless slot_index
  segments[slot_index][1] -= file_length
  segments[file_index][0] = "."
  segments.insert(slot_index, [file_id, file_length])
  # puts segments.map { |id, length| id.to_s * length }.join
end

# puts segments.map { |id, length| id.to_s * length }.join
map = segments.map { |id, length| id.to_s * length }.join

puts (0...map.length).sum { map[_1] == "." ? 0 : map[_1].to_i * _1 }
