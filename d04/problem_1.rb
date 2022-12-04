require_relative '../helper/aoc-helper'

inp = File.read('input.txt')

def fully_contains?(left, right)
  left_sections = sections(left)
  right_sections = sections(right)

  right_sections.first <= left_sections.first && left_sections.last <= right_sections.last ||
    left_sections.first <= right_sections.first && right_sections.last <= left_sections.last
end

def sections(range)
    left, right = range.split('-')

    left.to_i .. right.to_i
end

accum = 0

inp.lines.each do |line|
    left_elf, right_elf = line.split(',')
    accum += 1 if fully_contains?(left_elf, right_elf)
end

puts accum