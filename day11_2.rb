numbers = File.read("day11_data.txt").split(" ").map { Integer(_1) }

$cache = {}

def amount(number, steps)
  ($cache[number] ||= {})[steps] ||= begin
    if steps == 0
      1
    elsif number == 0
      amount(1, steps.pred)
    else
      digits = number.to_s.length

      if digits.even?
        divisor = 10**(digits / 2)
        amount(number / divisor, steps.pred) + amount(number % divisor, steps.pred)
      else
        amount(number * 2024, steps.pred)
      end
    end
  end
end

puts numbers.sum { amount(_1, 75) }
