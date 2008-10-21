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

require 'coiasira/version'
require 'coiasira/scheduler_error'
require 'coiasira/job_execution_error'
require 'coiasira/job_data'
require 'coiasira/job_detail'
require 'coiasira/trigger'
require 'coiasira/context'
require 'coiasira/base'
require 'coiasira/job_wrapper'
require 'coiasira/jobs'
require 'coiasira/runner'