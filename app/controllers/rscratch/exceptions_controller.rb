require_dependency "rscratch/application_controller"
module Rscratch
  class ExceptionsController < ApplicationController
    include SmartListing::Helper::ControllerExtensions
    helper  SmartListing::Helper    
    def index
      @exceptions = Rscratch::Exception.order("updated_at desc")
      smart_listing_create :exceptions, @exceptions, partial: "rscratch/exceptions/new_exception_smartlist"
      respond_to do |format|
        format.html # index.html.erb
        format.js
        format.json { render json: @exceptions }
      end      
    end
  end
end
