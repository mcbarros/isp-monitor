require "test_helper"

class CheckRouterJobTest < ActiveJob::TestCase
  setup do
    @router_config = router_configs(:one)
  end

  def with_default_routes(routes)
    RouterConfig.stub :find, @router_config do
      @router_config.stub :find_default_routes, routes do
        yield
      end
    end
  end

  test "raises an error if the router config doesnt exist" do
    assert_raises(ActiveRecord::RecordNotFound) do
      CheckRouterJob.new.perform("no-id")
    end
  end

  test "doesnt create a route status if there are no routes" do
    with_default_routes([]) do
      assert_no_changes -> { DefaultRouteStatus.count } do
        CheckRouterJob.new.perform(@router_config.id)
      end
    end
  end

  test "calls clean router job" do
    clean_id = nil

    with_default_routes([]) do
      CleanRouterJob.stub(:perform_later, ->(id) { clean_id = id }) do
        CheckRouterJob.new.perform(@router_config.id)
      end
    end

    assert_equal @router_config.id, clean_id
  end

  test "doesnt create a route status for disabled routes" do
    default_routes = [
      IpRoute.new(id: "some-id-1", distance: 1, active: true, disabled: true),
      IpRoute.new(id: "some-id-2", distance: 2, active: true, disabled: true)
    ]

    with_default_routes(default_routes) do
      assert_no_changes -> { DefaultRouteStatus.count } do
        CheckRouterJob.new.perform(@router_config.id)
      end
    end
  end

  test "create a route status for every non-disabled route" do
    default_routes = [
      IpRoute.new(id: "some-id-1", distance: 1, active: true, disabled: false),
      IpRoute.new(id: "some-id-2", distance: 2, active: true, disabled: false)
    ]

    with_default_routes(default_routes) do
      assert_difference -> { DefaultRouteStatus.count }, default_routes.size do
        CheckRouterJob.new.perform(@router_config.id)
      end
    end
  end
end
