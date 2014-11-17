require "thor"
require_relative 'generate_menus'

class GenMen < Thor
  desc 'generate SIZE', 'Generates test menu with SIZE items'
  def generate(size)
    Menu.new({num_items: size}).generate_file
  end

end

GenMen.start(ARGV)
