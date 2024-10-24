class RouterConfig < ApplicationRecord
  include RouterConnectable

  has_many :default_route_statuses, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, :host, :port, presence: true
  validates :port, numericality: { only_integer: true, greater_than: 0 }

  scope :checkable, -> { where(recurrent_checks: true) }

  encrypts :password

  def find_default_routes
    routes = execute_router_cmd("ip/route/getall")

    return routes unless routes.is_a?(Array)

    default_routes = routes.reject { |item| item[:"dst-address"] != "0.0.0.0/0" }
    primary_route = default_routes.min { |a, b| a[:distance] <=> b[:distance] }

    if primary_route
      primary_route[:primary] = true
    end

    default_routes.each do |route|
      route.transform_keys! { |key| key.to_s.sub("-", "_").sub(".", "").to_sym }
    end

    default_routes.map { |route| IpRoute.new_from_unsafe_hash(route) }.sort { |a, b| a.active ? -1 : 1 }
  end

  def disable_route(route_id)
    execute_router_cmd("ip/route/disable", { ".id": route_id })
  end

  def enable_route(route_id)
    execute_router_cmd("ip/route/enable", { ".id": route_id })
  end
end
