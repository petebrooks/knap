require "pry"

Item = Struct.new(:name, :price)

class Knapsack
  attr_reader :combinations

  def initialize(filename)
    @combinations = []
    get_values(filename)
    get_combinations
  end

  def to_s
    return "No possible combinations add up to #{@target}" if @combinations.length == 0

    print_string = ""

    @combinations.each_with_index do |combo, i|
      print_string << "Combination ##{i + 1}:\n"
      count_items(combo).each { |item, count| print_string << "   #{count} #{item.name}\n" }
    end

    print_string
  end

  private

  def get_combinations
    values = @items.map(&:price)
    min_value = values.min
    max_count = (@target / min_value).to_i

    (1..max_count).each do |n|
      @items.repeated_combination(n).each do |combo|
        combinations << combo if sum(combo) == @target
      end
    end
  end

  def extract_digits(str)
    str[/\d+\.\d+/].to_f
  end

  def set_target(line)
    @target = extract_digits(line) || 0
  end

  def add_item(line)
    @items ||= []
    name, price = line.split(',')
    @items << Item.new(name, extract_digits(price))
  end

  def sum(a)
    a.inject(0) { |sum, item| sum + item.price }
  end

  def get_values(filename)
    file = File.open(filename, 'r')
    file.readlines.each_with_index do |line, i|
      i == 0 ? set_target(line) : add_item(line)
    end
  end

  def count_items(item_names)
    count = {}
    item_names.each do |name|
      count[name] ? count[name] += 1 : count[name] = 1
    end
    count
  end

end

test_menus = Dir.entries('test_menus').select { |f| !File.directory? f }
test_menus.each do |name|
  unless name == 'menu3.txt'
    puts "---------------------------"
    puts "#{name}:"
    k = Knapsack.new("test_menus/#{name}")
    puts k
    p k.combinations
  end
end

# k = Knapsack.new('test_menus/menu5.txt')
# p k.sums
# p k.combinations
# puts k
