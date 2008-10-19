module Quartz
  class Base
    class << self
      def process(context)
        new.process(context)
      end
      
      def default_action
        'default'
      end
    end
    
    def initialize()
      @action = self.class.default_action
    end
    
    def process(context)
      puts context
      puts context.respond_to?(:action) if context
      puts context.action if context && context.respond_to?(:action)
      @action = context.action if context && context.respond_to?(:action) && context.action
      puts @action
      self.__send__(@action, context)
    end
  end
end