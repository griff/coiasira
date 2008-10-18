module Quartz
  class Base
    class << self
      def process(context)
        new.process(context)
      end
    end
    
    # Empty stuff
    def process(context)
    end
  end
end