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

  no_commands do
    def log(str)
      puts str if options[:verbose]
    end
  end

end

Knap.start(ARGV)
