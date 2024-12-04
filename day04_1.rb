WORD = "XMAS"

# rows = File.read("./day04_data.txt").split("\n").map(&:chars)
rows = File.read("./day04_data_test.txt").split("\n").map(&:chars)

row_length = rows.first.length

words = (0..rows.length.pred).map do |y|
  (0..row_length.pred).map do |x|
    horizontal = (x..x + WORD.length.pred).map { rows[y][_1] }.join
    vertical = (y..y + WORD.length.pred).map { rows.dig(_1, x) }.join
    diagonal1 = (0..WORD.length.pred).map { rows.dig(y + _1, x + _1) }.join
    diagonal2 = (0..WORD.length.pred).map { rows.dig(y + _1, x - _1) }.join

    [
      [horizontal, 'horizontal', x, y],
      [vertical, 'vertical', x, y],
      [diagonal1, 'diagonal1', x, y],
      [diagonal2, 'diagonal2', x, y]
    ]

    # [horizontal, vertical, diagonal1, diagonal2]
  end
end

# puts words.flatten.count { _1 == WORD || _1 == WORD.reverse }

pp rows

count = 0
words.flatten(2).each do |word, direction, x, y|
  if word == WORD || word == WORD.reverse
    puts "#{count += 1} Found #{word} at (#{x},#{y}) going #{direction}"
  end
end
