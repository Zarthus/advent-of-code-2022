inp = File.read('input.txt').chars
NUM = 14 # problem 1: set to 4

inp.length.times do |i|
  set = inp.slice(i, NUM)
  if NUM == set.uniq.length
    puts set.inspect
    puts i + NUM
    break
  end
end
