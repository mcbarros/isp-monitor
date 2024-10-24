require "test_helper"

class DefaultRouteStatusTest < ActiveSupport::TestCase
  setup do
    @router_config = router_configs(:one)
  end

  def new_status(router_config:, route_id: "new-id", status: "active")
    DefaultRouteStatus.new(
      router_config: router_config,
      route_id: route_id,
      status: status,
    )
  end

  test "should not save status without a router config" do
    route_status = new_status(router_config: nil)
    assert_not route_status.save
  end

  test "should not save status without a route id" do
    route_status = new_status(router_config: @router_config, route_id: nil)
    assert_not route_status.save
  end

  test "should save only when status has a valid valud" do
    {
      'active': true,
      'inactive': true,
      'invalid': false,
      nil: false
    }.each do |value, expected|
      route_status = new_status(router_config: @router_config, status: value)
      assert_equal route_status.save, expected
    end
  end

  test "should save route status" do
    route_status = new_status(router_config: @router_config)
    assert route_status.save
  end
end
