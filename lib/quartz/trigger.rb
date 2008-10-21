module Coiasira
  class Trigger
    attr_reader :data

    def initialize
      @data = JobData.new
    end
  end
end