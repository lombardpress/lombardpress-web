require 'test_helper'

class ActiveSupport::TestCase
  include Devise::TestHelpers
end

class TextControllerTest < ActionController::TestCase
	setup do
    request.host = "plaoulcommentary.lombardpress.org"
    Rails.application.config.action_mailer.default_url_options = { :host => 'lombardpress2.heroku.com' }
  end
  #anonymous tests
  test "should request index and get redirect when no user is logged in" do
    get :index
    assert_redirected_to "/users/sign_in"
  end
  
  #admin tests
  test "should request text#index and succeed when admin is logged in " do
  	sign_in users(:admin)
  	get :index
    assert :success
  end
  test "should request text#show and succeed when admin is logged in " do
    sign_in users(:admin)
    
    get :show, {'itemid' => "lectio1"}
    assert :success
  end
  
  #user tests
  test "should request text#index and succeed when user is logged in " do
  	sign_in users(:user)
  	get :index
    assert :sucess
  end
  test "should request text#show and redirect when user is logged in but does not have draft access " do
    sign_in users(:user)
    get :show, {'itemid' => "lectio1"}
    assert :redirect
  end
  test "should request text#show and succeed when user is logged in and has draft status access point" do
    sign_in users(:user)
    
    get :show, {'itemid' => "lectio1"}
    assert :success
  end
  test "should request text#show and redirect when user is logged in but does not have draft status access point" do
    sign_in users(:user)
    
    get :show, {'itemid' => "lectio2"}
    assert :redirect
  end

end
