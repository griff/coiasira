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

require 'quartz/version'
require 'quartz/job_data'
require 'quartz/job_detail'
require 'quartz/trigger'
require 'quartz/context'
require 'quartz/base'
require 'quartz/job_wrapper'
require 'quartz/jobs'
require 'quartz/runner'