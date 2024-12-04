WORD = "XMAS"
WORD_VARIATIONS = /(?=(#{WORD}|#{WORD.reverse}))/

rows = File.read("./day04_data.txt").split("\n").map(&:chars)
# rows = File.read("./day04_data_test.txt").split("\n").map(&:chars)

width = rows.first.length
height = rows.length

horizontal = rows.map { _1.join }
vertical = (0..width.pred).map { |x| (0..height.pred).map { |y| rows[y][x] }.join }

forward_diagonals = {}

(0..width.pred).each do |x|
  (0..height.pred).each do |y|
    (forward_diagonals[x - y] ||= []) << rows[y][x]
  end
end

backward_diagonals = {}

(0..width.pred).each do |x|
  (0..height.pred).each do |y|
    (backward_diagonals[x + y] ||= []) << rows[y][x]
  end
end

diagonals = forward_diagonals.values.concat(backward_diagonals.values).map(&:join)

sequences = [
  horizontal,
  vertical,
  diagonals
].flatten

puts sequences.sum { _1.scan(WORD_VARIATIONS).count }
