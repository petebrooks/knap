require 'thor'
require_relative 'knapsack'

class Knap < Thor
  class_option :verbose, :type => :boolean

  desc 'load FILE_PATH', 'Returns optimization.'
  long_desc <<-LONG_DESC
    `knap load`
  LONG_DESC
  def load(filename)
    log('Reading file...')
    puts Knapsack.new(filename)
  end

  no_commands do
    def log(str)
      puts str if options[:verbose]
    end
  end

end

Knap.start(ARGV)
