require 'thor'
require_relative 'knapsack'

class Knap < Thor
  SKIP_MENUS = ['no_target.txt', 'zero_target.txt', 'equal_menu.txt']

  class_option :verbose, :type => :boolean, :default => false, :aliases => ['-v']
  class_option :repeat, :type => :boolean, :default => true, :aliases => ['-r']
  class_option :counts, :type => :boolean, :default => false
  class_option :combinations, :type => :boolean, :default => false
  class_option :to_s, :type => :boolean, :default => true

  desc 'load FILE_PATH', 'Returns optimization'
  long_desc <<-LONG_DESC
    Loads and parses a file containing menu items and a target price.

    Expects file in this format:

    [target price]

    [item name],[item price]

    [item name],[item price]

    [...]
  LONG_DESC
  def load(filepath)
    start_time = Time.now
    knapsack = Knapsack.new(filepath, { verbose: options[:verbose], repeat: options[:repeat] })
    puts knapsack if options[:to_s]
    p knapsack.combinations if options[:combinations]
    p knapsack.counts if options[:counts]
    log "Completed solution in #{Time.now - start_time}"
  end

  desc 'test', 'run test files'
  method_option :run, :type => :string, :options => ['easy', 'all'], :default => 'all'
  def test
    if options[:run] == 'all'
      test_menus = Dir.entries('spec/test_menus').select { |f| !File.directory? f }
    else
      test_menus = ['easy_menu.txt']
    end
    time_report = []
    test_menus.each do |name|
      next if SKIP_MENUS.include?(name)
      say "=" * 50
      say "#{name}:", color = [:blue, :on_white]
      start_time = Time.now
      load("spec/test_menus/#{name}")
      time_report << "Finished #{name} in #{Time.now - start_time}"
    end
    time_report.each { |report| log report }
  end

  no_commands do
    def log(str)
      puts str if options[:verbose]
    end
  end

end

Knap.start(ARGV)
