require 'test_helper'
require 'pry'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
     assert true
  end
  test "tests to make sure user should not be created without email" do
	  value = User.create(email: nil, password: "changeme").valid?
	  assert_not value, "Saved the user without a title"
	end
	test "tests to make sure user should not be created without password" do
	  value = User.create(email: "test@example.com", password: nil).valid?
	  assert_not value, "Saved the user without a password"
	end
end
