module Coiasira
  class Runner
    def has_command?(cmd)
      Jobs.has_job?(cmd)
    end
    
    def process(cmd, context=nil)
      context.prepare if context.respond_to? :prepare
      Jobs.load_job(cmd).process(context)
    end
  end
end