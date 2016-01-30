require "rscratch/engine"
require "rscratch/configuration"

module Rscratch
  def self.configure
    yield configuration
  end
  def self.configuration
    @configuration ||= Configuration.new
  end  
end
