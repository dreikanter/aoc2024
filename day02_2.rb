def reports
  File.read("./day2_data.txt").split("\n").map do |row|
    row.split(/\s+/).map { |cell| Integer(cell) }
  end
end

# No zeroes in the input data
def altering_sign?(value, other)
  value.positive? != other.positive?
end

def out_of_range?(value)
  value.abs.then { _1 < 1 || _1 > 3 }
end

def find_first_unsafe_index(levels)
  return if levels.length < 2

  first_delta = levels[0] - levels[1]
  prev = levels[0]

  (1..levels.count.pred).find do |index|
    delta = prev - levels[index]
    prev = levels[index]
    altering_sign?(first_delta, delta) || out_of_range?(delta)
  end
end

def exclude_index(levels, index)
  levels[0, index].concat(levels[index.succ..-1])
end

def safe?(levels)
  first_unsafe = find_first_unsafe_index(levels)
  !first_unsafe || (0..first_unsafe).any? { !find_first_unsafe_index(exclude_index(levels, _1)) }
end

puts reports.count { |levels| safe?(levels) }
