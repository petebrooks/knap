require "thor"
require_relative 'generate_menus'

class MenuGen < Thor
  desc 'generate', 'Generates test menu'
  method_option :file_name, :type => :string, :aliases => ['-f', '--file']
  def generate
    say 'Generate Test Menu', color = [:black, :on_white]
    say 'Files will be saved to test_menus directory'

    options[:file_name] = demand('File name:') unless options[:file_name]
    options[:num_items] = demand('Number of items:')
    options[:guarantee_solveable] = yes?('Guarantee solveable?')
    options[:max_target_price] = demand('Maximum target price:') unless options[:guarantee_solveable]
    options[:max_item_price] = demand('Maximum item price:')

    menu = Menu.new(gen_options)
    file_path, target_price = menu.generate_file
    say("Generated new menu at #{file_path}")
    say("Target price: #{target_price}")
  end

  private
  def demand(prompt)
    answer = ask(prompt)
    while answer.empty?
      say 'Response required', color = :bold
      answer = ask(prompt)
    end
    answer
  end
end

MenuGen.default_task(:generate)

MenuGen.start(ARGV)
