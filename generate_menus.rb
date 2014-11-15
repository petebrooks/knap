require "faker"

def random_price(dollar_max)
  "$#{rand(dollar_max)}.#{rand(100)}"
end

def random_name(length)
  # name = ""
  # 6.times { name << [*'A'..'z'].sample }
  # name
  Faker::Lorem.word
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

def generate_single_menu(options={})
  file_name = options.fetch(:file_name, 'menu')
  num_items = options.fetch(:num_items, 50)
  max_target_price = options.fetch(:max_target_price, 100)
  max_item_price = options.fetch(:max_item_price, 50)
  item_name_length = options.fetch(:item_name_length, 6)

  f = File.new("test_menus/#{file_name}.txt", "w")
  f.puts random_target(max_target_price)
  num_items.times { f.puts random_item(item_name_length, max_item_price) }
end

options = { num_items: 10,
            max_target_price: 30,
            max_item_price: 10,
            item_name_length: 5 }
generate_menus(options)