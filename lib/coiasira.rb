$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

=begin comment
unless defined?(ActiveSupport)
  begin
    $:.unshift "#{File.dirname(__FILE__)}/../../activesupport/lib"
    require 'active_support'
  rescue LoadError
    require 'rubygems'
    begin
      gem 'activesupport'
    rescue LoadError
      require 'coiasira/core_ext'
    end
  end
end
=end

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

module Coiasira
  def self.silence_warnings
    oldv, $VERBOSE = $VERBOSE, nil
    begin
      yield
    ensure
      $VERBOSE = oldv
    end
  end
end