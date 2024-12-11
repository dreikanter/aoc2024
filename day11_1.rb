# numbers = File.read("day11_test_data.txt").split(" ").map { Integer(_1) }
numbers = File.read("day11_data.txt").split(" ").map { Integer(_1) }

25.times do
  result = []

  numbers.each do |number|
    if number == 0
      result << 1
      next
    end

    digits = Math.log10(number).to_i + 1

    if digits.even?
      divisor = 10**(digits / 2)
      result << number / divisor
      result << number % divisor
      next
    end

    result << number * 2024
  end

  numbers = result
end

puts numbers.count
