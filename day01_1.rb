list1, list2 = File.read("./day1_data.txt")
  .split("\n")
  .map { _1.split(/\s+/) }
  .map { [Integer(_1), Integer(_2)] }
  .transpose

sorted1 = list1.sort
sorted2 = list2.sort

distance = sorted1.zip(sorted2).map { (_1 - _2).abs }.sum
puts distance
