class CheckRouterJob < ApplicationJob
  queue_as :default

  def perform(router_config_id)
    router_config = RouterConfig.find(router_config_id)
    routes = router_config.find_default_routes

    unless routes.is_a?(Array)
      logger.warn("Error fetching default routes for #{router_config.name}: #{routes}")
      return
    end

    changes = []

    routes.each do |route|
      next if route.disabled

      last_status = DefaultRouteStatus.find_last_status(router_config_id: router_config.id, route_id: route.id)&.status
      new_status = route.active ? "active" : "inactive"

      if !last_status.nil? && last_status != new_status
        changes << route
        logger.info("Route #{route.id} changed from #{last_status} to #{new_status}")
      end

      DefaultRouteStatus.create(
        router_config: router_config,
        route_id: route.id,
        status: new_status
      )
    end

    NotificationMailer.with(changes: changes, destination: router_config.notification_email).status_change.deliver_now if changes.size > 0
    CleanRouterJob.perform_later(router_config_id)
  end
end
