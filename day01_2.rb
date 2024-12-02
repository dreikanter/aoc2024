list1, list2 = File.read("./day1_data.txt")
  .split("\n")
  .map { _1.split(/\s+/) }
  .map { [Integer(_1), Integer(_2)] }
  .transpose

list2_tally = list2.tally
list1.map { _1 * list2_tally[_1].to_i }.sum
