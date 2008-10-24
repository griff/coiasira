module Coiasira
  class JobWrapper
    attr_reader :job_class
    
    def initialize(name)
      @name = name
      @job_class = nil
    end
    
    def process(context)
      @job_class = Jobs.find_class(@name) unless job_class
      job_class.process(context)
    end
  end
end