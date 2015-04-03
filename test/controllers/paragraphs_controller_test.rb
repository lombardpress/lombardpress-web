require 'test_helper'

class ParagraphsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get xml" do
    get :xml
    assert_response :success
  end

  test "should get info" do
    get :info
    assert_response :success
  end

  test "should get plaintext" do
    get :plaintext
    assert_response :success
  end

end
