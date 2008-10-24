module Coiasira
  class Base
    # Accepts a logger conforming to the interface of Log4r or the default Ruby 1.8+ Logger class, which is then passed
    # on to any new database connections made and which can be retrieved on both a class and instance level by calling +logger+.
    unless defined? @@logger
      @@logger = nil
    end

    def self.logger
      @@logger
    end

    def self.logger=(obj)
      @@logger = obj
    end

    def logger
      @@logger
    end

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
    
#    def logger
#      merged.logger || self.class.logger
#    end
    
    def process(context)
      @action = context.action if context && context.respond_to?(:action) && context.action
      self.__send__(@action, context)
    end
  end
end