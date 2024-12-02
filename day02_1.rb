reports = File.read("./day2_data.txt").split("\n").map do |row|
  row.split(/\s+/).map { |cell| Integer(cell) }
end

level_distances = reports.map do |levels|
  (0..levels.length - 2).map { levels[_1] - levels[_1.succ] }
end

safe_reports_count = level_distances.count do |distances|
  distances.all? { _1.abs >= 1 && _1.abs <= 3 } && (distances.all?(&:positive?) || distances.all?(&:negative?))
end

puts safe_reports_count
