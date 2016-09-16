require 'test_helper'

class ActiveSupport::TestCase
  include Devise::Test::ControllerHelpers
end

class CommentsControllerTest < ActionController::TestCase
=begin
  setup do
    request.host = "scta.lombardpress.org"
    #Rails.application.config.action_mailer.default_url_options = { :host => 'lombardpress2.heroku.com' }
    sign_in users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end
=end
end
