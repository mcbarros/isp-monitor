class CheckAllRoutersJob < CronJob
  self.cron_expression = "*/5 * * * *"

  queue_as :default

  def perform
    # TODO: add config to wether check or not and filter here
    configs = RouterConfig.all

    configs.each do |router_config|
      CheckRouterJob.perform_later(router_config.id)
    end
  end
end
