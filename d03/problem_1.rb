require_relative '../helper/aoc-helper'

inp = File.read('input.txt')

def map_priority_letter(letter)
  fail "expected letter, got #{letter}" unless letter.match /[a-zA-Z]/

  if letter.match /[A-Z]/
    letter.ord - 38
  else
    letter.ord - 96
  end
end

## bad mans specs
fail "expected p to have value of 16" if map_priority_letter('p') != 16
fail "expected v to have value of 22" if map_priority_letter('v') != 22
fail "expected L to have value of 38" if map_priority_letter('L') != 38
fail "expected P to have value of 42" if map_priority_letter('P') != 42

accum = 0

inp.lines do |rucksack|
  rucksack = rucksack.chomp
  puts "rucksack = #{rucksack}"

  fail "rucksack length not divisable by 2" if rucksack.length % 2 != 0
  len = rucksack.length/2

  
  compartment_left, compartment_right = rucksack.chars.each_slice(len).map(&:join)
  next if compartment_left.nil?
  puts " .. rucksack compartments: #{compartment_left} | #{compartment_right}"

  letters_both_compartments_have = []
  rucksack_sum = 0
  compartment_left.chars.each do |letter|
    next if compartment_right.count(letter) == 0

    if letters_both_compartments_have.include? letter
        puts " .. rucksack already accounted for this letter: #{letter}"
        next
    end

    letters_both_compartments_have << letter 
    value = map_priority_letter(letter)
    puts " .. both compartments have letter #{letter} for value of #{value}"
    rucksack_sum += value
  end
  

  puts "rucksack total value: #{rucksack_sum}"
  accum += rucksack_sum
end

puts accum