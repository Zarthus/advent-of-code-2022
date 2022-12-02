require_relative '../helper/aoc-helper'

inp = File.read('input.txt')

rps = {
  A: :rock,
  X: :rock,
  B: :paper,
  Y: :paper,
  C: :scissors,
  Z: :scissors
}
points = {
  rock: 1,
  paper: 2,
  scissors: 3,
}
WIN_POINTS = 6
DRAW_POINTS = 3

accum_left = 0
accum_right = 0

inp.lines.each do |line|
  left, right = line.split(" ")

  lefthand = rps[left.to_sym]
  righthand = rps[right.to_sym]

  if lefthand == righthand
    accum_left += points[lefthand] + DRAW_POINTS
    accum_right += points[righthand] + DRAW_POINTS

    puts "Draw! #{lefthand} vs #{righthand}! Points total: #{accum_left} vs #{accum_right}"
    next
  end

  right_won = lefthand == :rock && righthand == :paper ||
              lefthand == :paper && righthand == :scissors ||
              lefthand == :scissors && righthand == :rock

  accum_left += points[lefthand] + (!right_won ? WIN_POINTS : 0)
  accum_right += points[righthand] + (right_won ? WIN_POINTS : 0)

  if right_won
    puts "You won this round with #{lefthand} vs #{righthand}! Points total: #{accum_left} vs #{accum_right}"
  else
    puts "You lost this round with #{lefthand} vs #{righthand}! Points total: #{accum_left} vs #{accum_right}"
  end
end

puts accum_right
