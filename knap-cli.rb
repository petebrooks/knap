require 'thor'
require_relative 'knapsack'

class Knap < Thor
  class_option :counts, :type => :boolean, :default => false
  class_option :combinations, :type => :boolean, :default => false
  class_option :to_s, :type => :boolean, :default => true

  desc 'load FILE_PATH', 'Returns optimization.'
  long_desc <<-LONG_DESC
    `knap load`
  LONG_DESC
  method_option :verbose, :type => :boolean, :default => false
  def load(filename)
    start_time = Time.now
    knapsack = Knapsack.new(filename, options[:verbose])
    puts knapsack if options[:to_s]
    p knapsack.combinations if options[:combinations]
    p knapsack.counts if options[:counts]
    log "Completed solution in #{Time.now - start_time}"
  end

  desc 'test', 'run test files'
  method_option :run, :type => :string, :options => ['easy', 'all'], :default => 'all'
  method_option :verbose, :type => :boolean, :default => true
  def test
    if options[:run] == 'all'
      test_menus = Dir.entries('spec/test_menus').select { |f| !File.directory? f }
    else
      test_menus = ['easy_menu.txt']
    end
    time_report = []
    test_menus.each do |name|
      log "=" * 50
      log "#{name}:"
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
