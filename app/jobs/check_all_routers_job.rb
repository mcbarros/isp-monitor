class CheckAllRoutersJob < CronJob
  self.cron_expression = "*/5 * * * *"

  queue_as :default

  def perform
    configs = RouterConfig.checkable

    configs.each do |router_config|
      CheckRouterJob.perform_later(router_config.id)
    end
  end
end
