require_relative '../helper/aoc-helper'

DEBUG = false
instructions = File.readlines('input.txt')[10..]

INSTRUCTION_REGEXP = Regexp.compile(/move (\d+) from (\d+) to (\d+)/)

cargo = begin
  column_matcher = Regexp.compile(/.([A-Z ]). .([A-Z ]). .([A-Z ]). .([A-Z ]). .([A-Z ]). .([A-Z ]). .([A-Z ]). .([A-Z ]).(?: .([A-Z ]))?/)

  containers = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [] }
  File.readlines('input.txt').first(9).each do |line|
    column = column_matcher.match(line)

    (1..9).each do |i|
      next if column[i].nil? || column[i] == " "
      containers[i] << column[i]
    end
  end

  (1..9).each { |i| containers[i].reverse! }

  containers
end

## some simple specs
fail "bad supply stack" if cargo[1][4] != "T"
fail "bad supply stack" if cargo[5][1] != "Q"

puts cargo.inspect if DEBUG
instructions.each do |instruction|
  instruction_set = INSTRUCTION_REGEXP.match(instruction)
  amount, from_column, to_column = [instruction_set[1].to_i, instruction_set[2].to_i, instruction_set[3].to_i]

  amount.times do |_|
    item = cargo[from_column].pop
    cargo[to_column] << item
  end
end
puts cargo.inspect if DEBUG

(1..9).each do |i|
  print cargo[i].last
end
$stdout.flush
