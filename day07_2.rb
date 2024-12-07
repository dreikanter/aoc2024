equations = File.read("day07_data.txt").split("\n").map do |line|
  result, operands = line.split(": ")
  operands = operands.split(" ").map { Integer(_1) }
  [Integer(result), operands]
end

OPERATORS = %w[+ * ||]

sum = 0

equations.each do |expected, operands|
  OPERATORS.repeated_permutation(operands.length.pred).each_with_index do |operators, index|
    result = operands.first

    (1...operands.length).each do |index|
      operator = operators[index.pred]
      operand = operands[index]

      case operator
      when "+"
        result += operand
      when "*"
        result *= operand
      when "||"
        result = (result.to_s + operand.to_s).to_i
      end

      break if result > expected
    end

    break sum += result if result == expected
  end
end

puts sum
