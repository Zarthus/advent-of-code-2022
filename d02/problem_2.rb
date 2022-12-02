require_relative '../helper/aoc-helper'

inp = File.read('input.txt')

rps = {
  A: :rock,
  B: :paper,
  C: :scissors,
}
winning_plays = {
  rock: :paper,
  paper: :scissors,
  scissors: :rock,
}
losing_plays = {
  rock: :scissors,
  paper: :rock,
  scissors: :paper,
}
strategyguide = {
  X: :lose,
  Y: :draw,
  Z: :win,
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
  strategy_to_apply = strategyguide[right.to_sym]
  if strategy_to_apply == :draw
    accum_left += points[lefthand] + DRAW_POINTS
    accum_right += points[lefthand] + DRAW_POINTS

    puts "Draw! #{lefthand} vs #{lefthand}! Points total: #{accum_left} vs #{accum_right}"
    next
  end

  righthand = strategy_to_apply == :win ? winning_plays[lefthand] : losing_plays[lefthand]
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
