class Monkey
    def initialize(id, starting_items, operation, divisble_by, throw_to_true, throw_to_false)
        @id = id
        @items = starting_items
        @operation = operation
        @divisble_by = divisble_by
        @throw_to_true = throw_to_true
        @throw_to_false = throw_to_false
        @inspections = 0
    end

    attr_accessor :items
    attr_accessor :inspections

    def worry(num)
        @operation.call(num)
    end

    def test(num)
        return @throw_to_true if (num % @divisble_by).zero?

        @throw_to_false
    end

    def inspect
        "#<Monkey #{@id} ins=#{@inspections} items=#{@items} div_by=#{@divisble_by} true=#{@throw_to_true} false=#{@throw_to_false}>"
    end
end

def parse_operation(op)
    parsed = /(.) ([\w\d]+)$/.match(op)

    meth = parsed[1].to_sym

    if parsed[2] == 'old'
        return lambda { |x| x.method(meth).call(x) } 
    end

    return lambda { |x| x.method(meth).call(parsed[2].to_i) } 
end

monkeys = {}
File.readlines('input.txt').map(&:chomp).each_slice(7) do |m|
    id = /Monkey (\d+):/.match(m[0])[1].to_i
    starting_items = m[1].scan(/\d+/).to_a.map(&:to_i)
    operation = parse_operation(m[2])
    divisble_by = m[3].match(/\d+/)[0].to_i
    if_true = m[4].match(/\d+/)[0].to_i
    if_false = m[5].match(/\d+/)[0].to_i

    monkeys[id] = Monkey.new(id, starting_items, operation, divisble_by, if_true, if_false)
end

rounds = 20

(1 .. rounds).each do |_|
    monkeys.each do |_, m|
        while m.items.any?
            m.inspections += 1
            
            item = m.items.shift
            item = m.worry(item) / 3

            to_monkey = m.test(item)
            monkeys[to_monkey].items << item
        end
    end
end

active_monkeys = monkeys.sort_by { |_, m| -m.inspections }.to_h
pp active_monkeys

puts monkeys.map { |_, m| m.inspections }.max(2).inject(:*)
