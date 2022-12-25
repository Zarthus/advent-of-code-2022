inp = File.readlines('input.txt').map(&:chomp)

def convert_to_int(char)
    return -2 if char == '='
    return -1 if char == '-'
    char.to_i
end

numbers = []
snafu = ''
inp.each do |line|
    sum = 0
    line.chars.map { |char| convert_to_int(char) }.reverse.each_with_index do |dec, pow|
        sum += dec * (5**pow)
    end
    numbers << sum
end

quotient = numbers.sum
while quotient > 0
    quotient, remainder = quotient.divmod(5)

    case remainder
    when 0, 1, 2
        snafu << remainder.to_s
    when 3
        quotient += 1
        snafu << '='
    when 4
        quotient += 1
        snafu << '-'
    end
end

puts snafu.reverse