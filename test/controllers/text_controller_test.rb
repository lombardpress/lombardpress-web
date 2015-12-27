require 'test_helper'

class ActiveSupport::TestCase
  include Devise::TestHelpers
end

class TextControllerTest < ActionController::TestCase
	setup do
    request.host = "www.test.host"
    Rails.application.config.action_mailer.default_url_options = { :host => 'lombardpress2.heroku.com' }
  end
  test "should request index and get redirect when no user is logged in" do
    get :index
    assert_redirected_to "/users/sign_in"
  end

end
