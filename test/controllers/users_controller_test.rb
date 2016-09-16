require 'test_helper'

class ActiveSupport::TestCase
  include Devise::Test::ControllerHelpers
end

class Users::ProfilesControllerTest < ActionController::TestCase
	setup do
    request.host = "scta.lombardpress.org"
    Rails.application.config.action_mailer.default_url_options = { :host => 'lombardpress2.heroku.com' }
  end
  # anonymous tests

  test "should request profiles#index and get redirect when no user is logged in" do
    get :index
    assert :redirect
  end
  test "should request profiles#show/1 and redirect when no user is logged in " do
    get :index, {'id' => "1"}
    assert :redirect
  end
  test "should request profiles#show/2 and redirect when no user is logged in " do
    get :index, {'id' => "2"}
    assert :redirect
  end

	#user tests
  test "should request text#index and succeed when user is logged in " do
  	sign_in users(:user)
  	get :index
    assert :redirect
  end
  test "should request profiles#show/1 and redirect when user is logged in " do
  	sign_in users(:user)
  	get :index, {'id' => "1"}
    assert :redirect
  end
  test "should request profiles#show/2 and succeed when user 2 is logged in as user 2 " do
  	sign_in users(:user)
  	get :index, {'id' => "2"}
    assert :success
  end

	## admin tests
  test "should request profiles#index and succeed when admin is logged in " do
  	sign_in users(:admin)
  	get :index
    assert :success
  end
  test "should request profiles#show/1 and succeed when admin is logged in " do
  	sign_in users(:admin)
  	get :index, {'id' => "1"}
    assert :success
  end
  test "should request profiles#show/2 and succeed when admin is logged in " do
  	sign_in users(:admin)
  	get :index, {'id' => "2"}
    assert :success
  end
end
