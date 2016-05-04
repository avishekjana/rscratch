require "rscratch/engine"
require "rscratch/configuration"

module Rscratch
  def self.configure
    yield configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end  

  def self.log_exception(exception, request)
    log = Rscratch::Exception.log(exception, request)
  end
end
