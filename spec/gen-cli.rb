require "thor"
require_relative 'generate_menus'

class GenMen < Thor
  desc 'generate', 'Generates test menu'
  def generate
    options = {}
    say('Generate Test Menu', color = [:black, :on_white])
    options[:file_name] = ask('File name:')
    options[:num_items] = ask('Number of items:')
    options[:guarantee_solveable] = yes?('Guarantee solveable?')
    options[:max_target_price] = ask('Maximum target price:') unless options[:guarantee_solveable]
    options[:max_item_price] = ask('Maximum item price:')

    menu = Menu.new(options)
    file_path, target_price = menu.generate_file
    say("Generated new menu at #{file_path}")
    say("Target price: #{target_price}")
  end

end

GenMen.start(ARGV)
