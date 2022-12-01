require_relative '../helper/aoc-helper'

sums = File.read('input.txt')
           .split("\n\n")
           .map { |section| section.lines.map(&:to_i).inject(:+) }

puts sums.max
puts sums.max(3).sum
