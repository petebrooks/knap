require "pry"

class Knapsack
  def initialize(filename)
    @target = 0
    @items = {}
    get_values(filename)
  end

  def combinations
    @combinations ||= possible_combinations.select { |e| sum(e) == @target }
  end

  def print_combinations
    puts "No possible combinations add up to #{@target}" if combinations == []
    combinations.each_with_index do |combo, i|
      puts "Combination ##{i + 1}:"
      count_items(combo).each { |item, count| puts "  #{count} #{item}" }
    end

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
    a.inject(0) { |sum, item| sum + item.last }
  end

  def get_values(filename)
    File.open(filename, 'r') do |file|
      file.readlines.each_with_index do |line, i|
        i == 0 ? set_target(line) : add_item(line)
      end
    end
  end

  def possible_combinations
    values = @items.values
    min_value = values.min
    max_count = @target / min_value
    min_count = values.include?(@target) ? 1 : 2

    combos = []

    (min_count..max_count).each do |n|
      @items.to_a.repeated_combination(n).each { |a| combos << a }
    end

    combos
  end

  def count_items(combo)
    count = {}
    item_names = combo.map { |item| item.first }
    unique_items = item_names.uniq
    unique_items.each { |item| count[item] = item_names.count(item) }
    count
  end

end

k = Knapsack.new('test_menus/menu3.txt')
p k.combinations.length
k.combinations
k.combinations
k.combinations
k.combinations
# p k.combinations.first
# p k.combinations.last
# k.print_combinations
# binding.pry