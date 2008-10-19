class Quartz::JobDetail
  attr_accessor :name, :group, :description
  attr_reader :data
  
  def initialize
    @data = JobData.new
  end
  
  def full_name
    "#{group}.#{name}"
  end
  
  def volatility=(value)
    @volatility = value
  end
  
  def volatility?
    @volatility
  end
  
  def durability=(value)
    @durability = value
  end
  
  def durability?
    @durability
  end
  
  def requests_recovery=(value)
    @requests_recovery = value
  end
  
  def requests_recovery?
    @requests_recovery
  end
  
  def stateful=(value)
    @stateful = value
  end
  
  def stateful?
    @stateful
  end
end