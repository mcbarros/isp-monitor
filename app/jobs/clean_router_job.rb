class CleanRouterJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 100

  def perform(router_config_id)
    router_config = RouterConfig.find(router_config_id)
    max_entries = router_config.max_check_entries || 0

    return if max_entries == 0

    loop do
      statuses = router_config.default_route_statuses.order(created_at: :desc).offset(max_entries).limit(BATCH_SIZE)
      statuses.destroy_all

      break if statuses.size < BATCH_SIZE
    end
  end
end
