require_dependency "rscratch/application_controller"

module Rscratch
  class DashboardController < ApplicationController
    def index
      @activity_log = Rscratch::ExceptionLog.select("count(id) as exception_count, date(created_at) as date").group("date(created_at)").order("date(created_at)").last(30)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @activity_log }
      end      
    end
  end
end
