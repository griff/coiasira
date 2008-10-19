class Quartz::Context
  attr_reader :merged, :details, :trigger
  
  def initialize
    @details = JobDetail.new
    @trigger = Trigger.new
    @merged = JobData.new
    @data = Hash.new
  end
  
  def [](key)
    @data[key]
  end
  
  def []=(key, value)
    @data[key] = value
  end
  
  def action
    details.data.action
  end
  
  def action=(value)
    details.data.action=value.to_s
  end
  
  def prepare
    @merged.merge! details.data
    @merged.merge! trigger.data
  end

  def method_missing(name, value=nil)
    sym = sym.to_s
    if sym =~ /^(.*)=$/
        return self[$~[1]] = value
    else
        return self[sym]
    end
  end
end