require 'test_helper'

class ActiveSupport::TestCase
  include Devise::Test::ControllerHelpers
end

class ErrorsControllerTest < ActionController::TestCase
  #test "should get not_found" do
  #  get :not_found
  #  assert_response :success
  #end

  #test "should get internal_server_error" do
  #  get :internal_server_error
  #  assert_response :success
  #end

end
