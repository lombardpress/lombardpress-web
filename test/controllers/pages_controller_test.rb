require 'test_helper'

class ActiveSupport::TestCase
  include Devise::TestHelpers
end

class PagesControllerTest < ActionController::TestCase
	setup do
    request.host = "plaoulcommentary.lombardpress.org"
    Rails.application.config.action_mailer.default_url_options = { :host => 'lombardpress2.heroku.com' }
  end
  test "should request pages#home and get redirect when no user is logged in" do
  	get :home
    assert_redirected_to "/users/sign_in"
  end
  test "should request pages#home and succeed when admin is logged in " do
  	sign_in users(:admin)
  	get :home
    assert :success
  end
  test "should request pages#home and succeed when user is logged in " do
  	sign_in users(:user)
  	get :home
    assert :success
  end
end
