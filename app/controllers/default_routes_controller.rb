class DefaultRoutesController < ApplicationController
  before_action :set_router_config, only: %i[ update history ]

  def index
    router_configs = RouterConfig.all
    @default_routes = Hash.new

    router_configs.each do |router_config|
      @default_routes[router_config] = router_config.find_default_routes
    end

    # https://www.ipify.org/
  end

  def update
    if params[:new_status]
      @router_config.enable_route(params[:route_id])
    else
      @router_config.disable_route(params[:route_id])
    end

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Route was successfully updated." }
      format.json { head :no_content }
    end
  end

  def history
    @history = @router_config.default_route_statuses.where(route_id: params[:route_id])
  end

  private
  def set_router_config
    @router_config = RouterConfig.find(params[:id])
  end
end
