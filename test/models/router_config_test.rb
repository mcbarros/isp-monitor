require "test_helper"

class RouterConfigTest < ActiveSupport::TestCase
  setup do
    @router_config = router_configs(:one)
  end

  def new_config(name: "new_test", host: "test.com", port: 8728)
    RouterConfig.new(
      name: name,
      host: host,
      port: port,
    )
  end

  test "should not save router config without name" do
    config = new_config(name: nil)
    assert_not config.save
  end

  test "should not save router config without host" do
    config = new_config(host: nil)
    assert_not config.save
  end

  test "should not save router config without port" do
    config = new_config(port: nil)
    assert_not config.save
  end

  test "should not save router config with invalid port" do
    config = new_config(port: "test")
    assert_not config.save
  end

  test "should not save router config with negative port" do
    config = new_config(port: -1)
    assert_not config.save
  end

  test "should not save router config with same name" do
    config = new_config(name: @router_config.name)
    assert_not config.save
  end

  test "should save router config" do
    config = new_config
    assert config.save
  end
end
