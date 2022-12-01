require_relative '../helper/aoc-helper'

inp = File.read('input.txt')

sections = inp.split("\n\n")

sums = []
sections.each do |section|
  sums.push section.split("\n").map(&:to_i).inject(:+)
end

sums.sort_by! { |a| -a }

puts sums[0] # answer 1
puts sums[0] + sums[1] + sums[2] # answer 2
