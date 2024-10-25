require "test_helper"

class CleanRouterJobTest < ActiveJob::TestCase
  setup do
    @config_one = router_configs(:one)
    @config_two = router_configs(:two)
    @config_three = router_configs(:three)

    2.times do
      @config_two.default_route_statuses.create(
        route_id: "any-id",
        status: "active"
      )
    end

    10.times do
      @config_three.default_route_statuses.create(
        route_id: "any-id",
        status: "active"
      )
    end
  end

  test "raises an error if the router config doesnt exist" do
    assert_raises(ActiveRecord::RecordNotFound) do
      CleanRouterJob.new.perform("no-id")
    end
  end

  test "doesnt delete any route status if max_check_entries is 0" do
    assert_equal 0, @config_one.max_check_entries

    assert_no_changes -> { DefaultRouteStatus.where(router_config: @config_one).count } do
      CleanRouterJob.new.perform(@config_one.id)
    end
  end

  test "doesnt delete any route status if max_check_entries <= current count" do
    assert_equal 2, @config_two.max_check_entries

    assert_no_changes -> { DefaultRouteStatus.where(router_config: @config_two).count } do
      CleanRouterJob.new.perform(@config_two.id)
    end
  end

  test "delete route status until count = max_check_entries" do
    assert_equal 4, @config_three.max_check_entries

    assert_difference -> { DefaultRouteStatus.where(router_config: @config_three).count }, -6 do
      CleanRouterJob.new.perform(@config_three.id)
    end
  end
end
