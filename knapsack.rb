Item = Struct.new(:name, :price)

class Knapsack

  def initialize(filename, verbose=false)
    raise ArgumentError, 'Argument must be a valid filename' unless File.file?(filename)
    @verbose = verbose
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

    print_string = []

    counts.each_with_index do |count, i|
      print_string << "Combination ##{i + 1}:"
      print_string << count.map { |item, count| "   #{count} #{item.name}" }
    end

    print_string.join("\n")
  end

  private

  def extract_digits(str)
    return nil unless str.is_a?(String)
    str[/\d+\.\d+/].to_f
  end

  def set_target(line)
    @target = extract_digits(line) || 0
    raise "Could not set target price. Check formatting." if @target.nil?
    raise "Target price must be greater than 0." if @target <= 0
  end

  def add_item(line)
    @items ||= []
    name, price_string = line.split(',')
    price = extract_digits(price_string)
    if !name || !price
      log("Formatting error. Skipping line: '#{line}'")
    elsif price <= 0
      log("Item price is zero or negative. Skipping line: '#{line}'")
    elsif price > @target
      log("Item price is greater than target price. Skipping line: '#{line}'")
    else
      @items << Item.new(name, price)
    end
  end

  def sum(a)
    a.inject(0) { |sum, item| sum + item.price }
  end

  def get_values(filename)
    file = File.open(filename, 'r')
    log('Parsing file...')
    file.readlines.each_with_index do |line, i|
      i == 0 ? set_target(line) : add_item(line)
    end
  end

  def get_combinations
    return [] if @target <= 0 || @items.empty?

    values       = @items.map(&:price)
    min_value    = values.min
    max_count    = (@target / min_value).to_i
    combinations = []

    start_time = Time.now
    (1..max_count).each do |n|
      @items.repeated_combination(n).each do |combo|
        combinations << combo if sum(combo) == @target
      end
    end
    log("Completed all combinations in #{Time.now - start_time}")

    combinations
  end

  def get_counts(combo)
    count = {}
    combo.each do |name|
      count[name] ? count[name] += 1 : count[name] = 1
    end
    count
  end

  def log(message)
    puts message if @verbose
  end

end

# DRIVER TEST CODE

# test_menus = Dir.entries('spec/test_menus').select { |f| !File.directory? f }
# test_menus.each do |name|
#   unless name == 'menu3.txt'
#     puts "---------------------------"
#     puts "#{name}:"
#     k = Knapsack.new("test_menus/#{name}")
#     start_time = Time.now
#     puts k
#     puts "Finished #{name} in #{Time.now - start_time}"
#     # p k.combinations
#     # p k.counts
#   end
# end

# k = Knapsack.new("/Users/petebrooks/code/knap/test_menus/menu3.txt")
# puts "-----------------------------"
# p k.combinations.length
# puts "-----------------------------"
# p k.counts.length
# puts "-----------------------------"
# p k.to_s