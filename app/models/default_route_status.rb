class DefaultRouteStatus < ApplicationRecord
  belongs_to :router_config

  validates :route_id, :status, presence: true
  validates :status, inclusion: { in: %w[active inactive], message: "%{value} is not a valid status" }

  default_scope { order(created_at: :desc) }

  def self.find_last_status(router_config_id:, route_id:)
    where(router_config_id: router_config_id, route_id: route_id).first
  end

  def active?
    status == "active"
  end
end
