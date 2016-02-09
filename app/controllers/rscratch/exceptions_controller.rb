require_dependency "rscratch/application_controller"
module Rscratch
  class ExceptionsController < ApplicationController
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper    

    before_filter :set_exception, :only => [:show, :toggle_ignore, :resolve]

    def index
      @exceptions = Rscratch::Exception.order("updated_at desc")
      smart_listing_create :exceptions, @exceptions.by_status('new'), partial: "rscratch/exceptions/exception_smartlist"
      smart_listing_create :resolved_exceptions, @exceptions.by_status('resolved'), partial: "rscratch/exceptions/exception_smartlist"
      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.json { render json: @exceptions }
      end      
    end

    def show
      @log = @excp.exception_logs.order("created_at desc").page(params[:page]).per(1)
      @historical_data = @excp.exception_logs.select("count(id) as exception_count, date(created_at) as date").group("date(created_at)").order("date(created_at)").last(30) if params[:page] == "1"
      rescue Exception => @error          
    end  

    def log

    end
    
    def toggle_ignore
      @excp.toggle_ignore!
      @excp.reload
      rescue Exception => @error          
    end

    def resolve
      @excp.resolve!
      @excp.reload
      rescue Exception => @error          
    end    

    private

    def set_exception
      @excp = Rscratch::Exception.find(params[:id])
    end
  end
end
