require 'faker'

TestItem = Struct.new(:name, :price) do
  def to_s
    "#{name},$#{price}"
  end
end

class Menu
  attr_reader :target_price, :file_path

  def initialize(options={})
    file_name            = options[:file_name] || 'generated_menu'
    @file_path           = File.absolute_path("test_menus/#{file_name}.txt")
    @num_items           = options[:num_items].to_i || 6
    @max_target_price    = options[:max_target_price] || 100
    @max_item_price      = options[:max_item_price] || 50
    @guarantee_solveable = options[:guarantee_solveable] || false

    @items = Array.new(@num_items) { make_item }
  end

  def generate_file
    if @guarantee_solveable
      @target_price = make_target_price
    else
      @target_price = random_price(@max_target_price)
    end

    target = make_price_string(@target_price)

    f = File.new("#{@file_path}", "w")
    @items.each { |item| f.puts item }

    [@file_path, @target_price]
  end

  private

  def random_price(dollar_max=50, dollar_min=0.5)
    rand(dollar_min.to_f..dollar_max.to_f).round(2)
  end

  def make_price_string(price)
    "$#{price}"
  end

  def make_item
    name = random_name
    price = random_price(@max_item_price, @min_item_price)
    TestItem.new(name, price)
  end

  def random_name
    Faker::Lorem.word
  end

  def make_target_price
    item_prices = @items.map(&:price)
    sample_size = rand(1..item_prices.length)
    sample_items = item_prices.sample(sample_size)
    sample_items.inject(:+).round(2)
  end

end