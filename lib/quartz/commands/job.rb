if defined? Rails::Initializer
  require 'quartz/rails/initializer'
  require "#{RAILS_ROOT}/config/environment"
end

setup if ARGV.include?('--help') || ARGV.include?('-h') || ARGV.size == 0

command = ARGV.shift
runner = Quartz::Runner.new

unless runner.has_command?(command)
  puts "No job named '#{command}'"
  setup
end
  
context = Quartz::Context.new
if( ARGV.size > 0 )
  context.action = ARGV.shift
  ARGV.each do |arg|
    [name,value] = arg.split('=')
    context.details.data[name] = value
  end
end
runner.process(command, context)

def setup
  puts "script/job <job_name> [action] [arguments]"
  exit 1
end