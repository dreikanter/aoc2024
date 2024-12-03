data = File.read("./day03_data.txt")

puts data.scan(/mul\((\d{1,3}),(\d{1,3})\)/).sum { |a, b| Integer(a) * Integer(b) }
