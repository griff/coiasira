module Coiasira
  class JobWrapper
    attr_reader :job_class
    
    def initialize(name, data, file)
      @name = name
      @data = data
      @file = file
      @first_run = true
      @job_class = nil
    end
    
    def process(context)
      @job_class = Jobs.find_class(@name) unless job_class
      job_class.process(context)
    end
  end
end