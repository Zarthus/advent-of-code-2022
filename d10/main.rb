inp = File.readlines('input.txt').map(&:chomp)

cycles_taken = { 'noop' => 1, 'addx' => 2 }
items = [1]

inp.each do |line|
    instruction, value = line.split(' ')
    cycles = cycles_taken[instruction]

    (1..cycles).each do |cycle| 
        items << (cycle == cycles ? items.last + value.to_i : items.last)
    end
end

# answer 1
puts "answer 1: " + ([20, 60, 100, 140, 180, 220].map { |i| items[i - 1] * i }.sum).to_s

crt = []
items.each_with_index do |sprite, idx|
    pos = idx % 40
    crt << ((sprite-1 .. sprite+1).to_a.include?(pos) ? '#' : ' ')
    crt << "\n" if pos == 39
end

crt.pop
crt.each { |c| print c }