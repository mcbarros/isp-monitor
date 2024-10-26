require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IspMonitor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :delayed_job

    if ENV["RAILS_SMTP_HOST"].present?
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = {
        address: ENV["RAILS_SMTP_HOST"],
        port: ENV["RAILS_SMTP_PORT"] || 587,
        domain: ENV["RAILS_SMTP_DOMAIN"],
        user_name: ENV["RAILS_SMTP_USERNAME"],
        password: ENV["RAILS_SMTP_PASSWORD"],
        authentication: ENV["RAILS_SMTP_AUTH_TYPE"] || "plain",
        enable_starttls: true,
        open_timeout: 5,
        read_timeout: 5
      }
    end
  end
end
