module Quartz
  class JobData < Hash
    def method_missing(sym, value=nil)
      sym = sym.to_s
      puts "JobData Method missing " + sym
      if sym =~ /^(.*)=$/
        return self[$~[1]] = value
      else
        return self[sym]
      end
    end
  end
end