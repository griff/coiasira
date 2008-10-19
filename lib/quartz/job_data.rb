class Quartz::JobData < Hash
  def method_missing(name, value=nil)
    sym = sym.to_s
    if sym =~ /^(.*)=$/
        return self[$~[1]] = value
    else
        return self[sym]
    end
  end
end