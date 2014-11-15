require "pry"

class Knapsack
  attr_reader :sums, :items, :target
  def initialize(filename)
    get_values(filename)
  end

  def sums
    @sums ||= get_sums
  end

  def combinations
    @combinations ||= sums.keys.select { |combo| sums[combo] == @target }
  end

  def to_s
    return "No possible combinations add up to #{@target}" if combinations.length == 0

    print_string = ""
    combinations.each_with_index do |combo, i|
      print_string << "Combination ##{i + 1}:\n"
      count_items(combo).each { |item, count| print_string << "  #{count} #{item}\n" }
    end
    print_string
  end

  def get_sums
    values = @items.values
    min_value = values.min
    max_count = @target / min_value
    min_count = values.include?(@target) ? 1 : 2

    sums = {}

    (min_count..max_count).each do |n|
      @items.keys.repeated_combination(n).each do |c|
        sums[c[0..-2]] ? sums[c] = sums[c[0..-2]] + @items[c.last] : sums[c] = sum(c)
      end
    end

    sums
  end

  private

  # def symsnakeify(str)
  #   str.gsub(/\s/, '_').to_sym
  # end

  # def unsymsnakeify(sym)
  #   sym.to_s.gsub('_', ' ')
  # end

  def extract_digits(str)
    str[/\d+\.\d+/].to_f
  end

  def set_target(line)
    @target = extract_digits(line)
  end

  def add_item(line)
    arr = line.split(',')
    @items[arr.first] = extract_digits(arr.last)
  end

  def sum(a)
    a.inject(0) { |sum, item| sum + @items[item] }
  end

  def get_values(filename)
    @target = 0
    @items = {}
    File.open(filename, 'r') do |file|
      file.readlines.each_with_index do |line, i|
        i == 0 ? set_target(line) : add_item(line)
      end
    end
  end

  def count_items(item_names)
    count = {}
    unique_items = item_names.uniq
    unique_items.each { |item| count[item] = item_names.count(item) }
    count
  end

end

k = Knapsack.new('test_menus/menu5.txt')
# p k.sums
# p k.target
# p k.combinations.length
# p k.combinations
puts k