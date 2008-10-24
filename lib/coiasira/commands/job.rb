if defined? Rails::Initializer
  require "#{RAILS_ROOT}/config/environment"
end

def setup
  puts "script/job <job_name> [action] [arguments]"
  exit 1
end

setup if ARGV.include?('--help') || ARGV.include?('-h') || ARGV.size == 0

command = ARGV.shift
runner = Coiasira::Runner.new

unless runner.has_command?(command)
  puts "No job named '#{command}'"
  setup
end

log = Logger.new(STDOUT)
log.level = Logger::DEBUG
Coiasira::Base.logger = log

context = Coiasira::Context.new
if( ARGV.size > 0 )
  action = ARGV.shift
  context.action = action
  ARGV.each do |arg|
    name, value = arg.split('=')
    context.details.data[name] = value
  end
end
runner.process(command, context)