require "faker"

def random_price(dollar_max=50, dollar_min=0.5)
  # "#{rand(dollar_max)}.#{rand(10)}#{rand(10)}".to_f
  rand(dollar_min.to_f..dollar_max.to_f).round(2)
end

def make_price_string(price)
  "$#{price}"
end

def make_item(price)
  "#{random_name},#{make_price_string(price)}"
end

def random_name(length=nil)
  return Faker::Lorem.word if length == nil
  raise ArgumentError('Length argument must be an integer') unless length.is_a?(Integer)
  name = ""
  length.times { name << [*'A'..'z'].sample }
  name
end

def random_target(max_price=100)
  random_price(max_price)
end

def random_item(name_length=6, max_price=50)
  "#{random_name(name_length)},#{random_price(max_price)}"
end

def generate_menus(options={})
  file_nums = options.fetch(:file_nums, (4..6))

  file_nums.each do |n|
    options[:file_name] = "menu#{n}"
    generate_single_menu(options)
  end
end

# def generate_single_menu(options={})
#   file_name = options.fetch(:file_name, 'menu')
#   num_items = options.fetch(:num_items, 50)
#   max_target_price = options.fetch(:max_target_price, 100)
#   max_item_price = options.fetch(:max_item_price, 50)
#   item_name_length = options.fetch(:item_name_length, 6)

#   f = File.new("test_menus/#{file_name}.txt", "w")
#   f.puts random_target(max_target_price)
#   num_items.times { f.puts random_item(item_name_length, max_item_price) }
# end

def generate_single_menu(options={})
  file_name = options.fetch(:file_name, 'menu')
  num_items = options.fetch(:num_items, 50)
  max_target_price = options.fetch(:max_target_price, 100)
  max_item_price = options.fetch(:max_item_price, 50)
  # item_name_length = options.fetch(:item_name_length, 6)
  guarantee_solveable = options.fetch(:guarantee_solveable, false)

  item_prices = Array.new(num_items) { random_price(max_item_price) }
  target_price = if guarantee_solveable
    item_prices.sample(rand(1..num_items)).inject(:+)
  else
    random_price(max_target_price)
  end

  target = make_price_string(target_price)
  items = item_prices.map { |price| make_item(price) }

  f = File.new("test_menus/#{file_name}.txt", "w")
  f.puts target
  items.each { |item| f.puts item }
end

options = { num_items: 6,
            max_target_price: 30,
            max_item_price: 10,
            guarantee_solveable: true }
generate_menus(options)