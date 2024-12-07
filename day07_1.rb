# equations = File.read("day07_test_data.txt").split("\n").map do |line|
equations = File.read("day07_data.txt").split("\n").map do |line|
  result, operands = line.split(": ")
  operands = operands.split(" ").map { Integer(_1) }
  [Integer(result), operands]
end

OPERATORS = %w[+ *]

sum = 0

equations.each do |expected, operands|
  OPERATORS.repeated_permutation(operands.length.pred).each_with_index do |operators, index|
    result = operands.first

    (1...operands.length).each do |index|
      operator = operators[index.pred]
      operand = operands[index]

      if operator == "+"
        result += operand
      else
        result *= operand
      end

      break if result > expected
    end

    if result == expected
      sum += result
      break
    end
  end
end

puts sum
