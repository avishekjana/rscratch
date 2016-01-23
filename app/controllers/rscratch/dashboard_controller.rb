require_dependency "rscratch/application_controller"

module Rscratch
  class DashboardController < ApplicationController
    def index
      @exceptions = Rscratch::Exception.all
      respond_to do |format|
        format.html # index.html.erb
      end      
    end
  end
end
