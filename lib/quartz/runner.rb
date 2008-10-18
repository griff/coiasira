module Quartz
  class Runner
    def call(cmd, context)
      Jobs.load_job(cmd).process(context)
    end
  end
end