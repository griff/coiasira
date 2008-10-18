if defined? Rails::Initializer
  require 'quartz/rails/initializer'
  require "#{RAILS_ROOT}/config/environment"
end
#ARGV.shift if ['--help', '-h'].include?(ARGV[0])
Quartz::Runner.new.process(ARGV[0])