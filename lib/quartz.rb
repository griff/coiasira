$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(ActiveSupport)
  begin
    $:.unshift "#{File.dirname(__FILE__)}/../../activesupport/lib"
    require 'active_support'
  rescue LoadError
    require 'rubygems'
    gem 'activesupport'
  end
end

require 'quartz/base'
require 'quartz/job'
require 'quartz/jobs'
require 'quartz/runner'