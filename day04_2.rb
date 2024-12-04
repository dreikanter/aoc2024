WORD = "MAS"
WORD_VARIATIONS = [WORD, WORD.reverse]

data = File.read("./day04_data.txt").split("\n").map(&:chars)

width = data.first.length
height = data.length


count = 0

(1..height - 2).each do |y|
  (1..width - 2).each do |x|
    words = [
      [data[y - 1][x + 1], data[y][x], data[y + 1][x - 1]].join,
      [data[y - 1][x - 1], data[y][x], data[y + 1][x + 1]].join
    ]

    count += 1 if words.all? { WORD_VARIATIONS.include?(_1) }
  end
end

puts count
