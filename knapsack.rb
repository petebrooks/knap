Item = Struct.new(:name, :price)

class Knapsack

  def initialize(filename)
    get_values(filename)
  end

  def combinations
    @combinations ||= get_combinations
  end

  def counts
    @counts ||= combinations.map { |combo| get_counts(combo) }
  end

  def to_s
    return "No possible combinations add up to #{@target}" if combinations.length == 0

    print_string = ""

    counts.each_with_index do |count, i|
      print_string << "Combination ##{i + 1}:\n"
      count.each { |item, count| print_string << "   #{count} #{item.name}\n" }
    end

    print_string
  end

  private

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

  def get_combinations
    return [] if @target <= 0

    values = @items.map(&:price)
    min_value = values.min
    max_count = (@target / min_value).to_i

    combinations = []

    (1..max_count).each do |n|
      @items.repeated_combination(n).each do |combo|
        sum = sum(combo)
        next if sum > @target
        combinations << combo if sum == @target
      end
    end

    combinations
  end

  def get_counts(combo)
    count = {}
    combo.each do |name|
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
    start_time = Time.now
    puts k
    puts "Finished #{name} in #{Time.now - start_time}"
    # p k.combinations
    # p k.counts
  end
end