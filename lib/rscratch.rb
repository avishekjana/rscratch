require "rscratch/engine"
require "rscratch/configuration"

module Rscratch
  def self.configure
    yield configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end  

  def self.log_exception(_e,_r)
    log = Exception.log(_e, _r)
  end
end
