require "test_helper"

class RouterConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @router_config = router_configs(:one)
  end

  test "should get index" do
    get router_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_router_config_url
    assert_response :success
  end

  test "should create router_config" do
    assert_difference("RouterConfig.count") do
      post router_configs_url, params: { router_config: { host: "new_test", name: "new_test", password: "test", port: 8728, user: "test" } }
    end

    assert_redirected_to router_configs_url
  end

  test "should get edit" do
    get edit_router_config_url(@router_config)
    assert_response :success
  end

  test "should update router_config" do
    patch router_config_url(@router_config), params: { router_config: { host: "new_test", name: "new_test", password: nil, port: 8728, user: "test" } }
    assert_redirected_to router_configs_url
  end

  test "should destroy router_config" do
    assert_difference("RouterConfig.count", -1) do
      delete router_config_url(@router_config)
    end

    assert_redirected_to router_configs_url
  end
end
