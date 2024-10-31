require "test_helper"

class FirstAccessControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_first_access_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post first_access_url, params: { user: { email: "test@test.com", password: "test", password_confirmation: "test" } }
    end

    assert_redirected_to root_url
  end
end
