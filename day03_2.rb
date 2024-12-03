data = File.read("./day03_data.txt")

enabled = true

results = data.scan(/(do)\(\)|(don't)\(\)|(mul)\((\d{1,3}),(\d{1,3})\)/).filter_map do |group|
  action, a, b = group.compact

  if action == "mul"
    enabled ? Integer(a) * Integer(b) : 0
  elsif action == "do"
    enabled = true
    0
  elsif action == "don't"
    enabled = false
    0
  end
end

puts results.sum
