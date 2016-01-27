require 'test_helper'

module Rscratch
  class ExceptionsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
