module Quartz
  class Job
    attr_reader :job_class
    
    def initialize(name, data, file)
      @name = name
      @data = data
      @file = file
      @first_run = true
      @job_class = nil
    end
    
    def process(context)
      unless job_class
        ret = eval(@data, binding, @file)
        if @first_run
          @job_class = Jobs.find_class(@name)
        end
        @first_run = false
      end
      if job_class
        job_class.process(context)
      end
    end
  end
end