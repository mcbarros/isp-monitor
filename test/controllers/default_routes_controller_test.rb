require "test_helper"

class DefaultRoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get default_routes_index_url
    assert_response :success
  end
end
