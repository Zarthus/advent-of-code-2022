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

def find_badge(r1, r2, r3)
  r1.chomp.chars.each do |char|
    next unless r2.include? char
    next unless r3.include? char

    return char
  end

  fail "could not find badge between rucksacks"
end

accum = 0

inp.lines.each_slice(3) do |rucksack_group|
  badge = find_badge(rucksack_group[0], rucksack_group[1], rucksack_group[2])
  accum += map_priority_letter(badge)
end

puts accum