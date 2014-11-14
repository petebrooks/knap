@target = 0
@items = {}

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

File.open('menu.txt', 'r') do |file|
  file.readlines.each_with_index do |line, i|
    i == 0 ? set_target(line) : add_item(line)
  end
end

min_value = @items.values.min
sorted_items = @items.sort_by { |item, price| price }
combos = []
max = @target / min_value

(1..max).each do |n|
  @items.to_a.repeated_combination(n).each {|a| combos << a}
end

combos.each { |e| p e if sum(e) == @target }