module Rscratch
  class ApplicationController < ActionController::Base
    before_action :authenticate

    def authenticate
      if Rscratch.configuration.authenticate
        instance_eval(&Rscratch.configuration.authenticate)
      end
    end

  end
end
