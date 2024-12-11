numbers = File.read("day11_data.txt").split(" ").map { Integer(_1) }

25.times do
  result = []

  numbers.each do |number|
    if number == 0
      result << 1
    else
      digits = Math.log10(number).to_i + 1

      if digits.even?
        divisor = 10**(digits / 2)
        result << number / divisor
        result << number % divisor
      else
        result << number * 2024
      end
    end

    numbers = result
  end
end

puts numbers.count
