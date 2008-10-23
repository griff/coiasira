module Coiasira
  class JobExecutionError < SchedulerError
    attr_accessor :refire, :unschedule_firing_trigger, :unchedule_all_triggers
    
    def initialize(options={})
      options.assert_valid_keys(:refire_immediately, :unschedule_firing_trigger, :unchedule_all_triggers)
      @refire = options[:refire_immediately] || false
      @unschedule_trigger = options[:unschedule_firing_trigger] || false
      @unchedule_all_triggers = options[:unchedule_all_triggers] || false
    end
  end
end