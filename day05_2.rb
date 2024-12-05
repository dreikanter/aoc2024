RULES = File.read("day05_rules.txt").split("\n").map { _1.split("|").map(&:to_i) }
SEQUENCES = File.read("day05_sequences.txt").split("\n").map { _1.split(",").map(&:to_i) }

def find_incorrect_pair(sequence, after = 0)
  (after..sequence.length.pred).find do |first|
    (first.succ..sequence.length.pred).find do |last|
      return [first, last] unless RULES.include?([sequence[first], sequence[last]])
    end
  end
end

def incorrect
  SEQUENCES.filter do |sequence|
    (0..sequence.length.pred).any? do |first|
      (first.succ..sequence.length.pred).any? do |last|
        !RULES.include?([sequence[first], sequence[last]])
      end
    end
  end
end

def correct_sequence(sequence, after = 0)
  indexes = find_incorrect_pair(sequence, after)
  return sequence unless indexes
  sequence[indexes[0]], sequence[indexes[1]] = sequence[indexes[1]], sequence[indexes[0]]
  correct_sequence(sequence, indexes[0])
end

puts incorrect.sum { correct_sequence(_1)[(_1.length / 2)] }
