module Rscratch
  class ApplicationController < ActionController::Base
    before_filter :authenticate

    def authenticate
      if Rscratch.configuration.authenticate
        instance_eval(&Rscratch.configuration.authenticate)
      end
    end
    
  end
end
