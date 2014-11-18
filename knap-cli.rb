require 'thor'
require_relative 'knapsack'

class Knap < Thor
  class_option :verbose, :type => :boolean, :default => false

  desc 'load FILE_PATH', 'Returns optimization.'
  long_desc <<-LONG_DESC
    `knap load`
  LONG_DESC
  def load(filename)
    start_time = Time.now
      @knapsack = Knapsack.new(filename, options[:verbose])
    puts @knapsack
    log("Completed solution in #{Time.now - start_time}")
  end

  class_option :verbose, :type => :boolean, :default => true
  class_option :counts, :type => :boolean, :default => false
  class_option :combinations, :type => :boolean, :default => false
  class_option :to_s, :type => :boolean, :default => true
  class_option :all, :type => :boolean, :default => true
  desc 'test', 'run all test files'
  def test
    if options[:all]
      test_menus = Dir.entries('spec/test_menus').select { |f| !File.directory? f }
    else
      test_menus = ['spec/test_menus/menu1.txt']
    end
    time_report = []
    test_menus.each do |name|
      log "---------------------------"
      log "#{name}:"
      k = Knapsack.new("spec/test_menus/#{name}", options[:verbose])
      start_time = Time.now
      puts k if options[:to_s]
      p k.combinations if options[:combinations]
      p k.counts if options[:counts]
      time_report << "Finished #{name} in #{Time.now - start_time}"
    end
    time_report.each { |report| puts report }
  end

  no_commands do
    def log(str)
      puts str if options[:verbose]
    end
  end

end

Knap.start(ARGV)
