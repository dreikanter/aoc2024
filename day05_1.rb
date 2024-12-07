rules = File.read("day05_rules.txt").split("\n").map { _1.split("|").map(&:to_i) }
sequences = File.read("day05_sequences.txt").split("\n").map { _1.split(",").map(&:to_i) }

correct = sequences.filter do |sequence|
  (0..sequence.length.pred).all? do |first|
    (first.succ..sequence.length.pred).all? do |last|
      rules.include?([sequence[first], sequence[last]])
    end
  end
end

puts correct.sum { _1[(_1.length / 2)] }
