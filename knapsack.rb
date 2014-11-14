class Knapsack
  def initialize(filename)
    @target = 0
    @items = {}
    get_values(filename)
  end

  def combinations
    possible_combinations.select { |e| sum(e) == @target }
  end

  private

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
    min_value = @items.values.min
    max_count = @target / min_value

    combos = []

    (1..max_count).each do |n|
      @items.to_a.repeated_combination(n).each { |a| combos << a }
    end

    combos
  end

end

k = Knapsack.new('menu.txt')
p k.combinations.first
p k.combinations.last