class DefaultRoutesController < ApplicationController
  before_action :set_router_config, only: %i[ update history ]

  def index
    router_configs = RouterConfig.all
    @default_routes = Hash.new
    @current_ip_address = Ipify.get_current_ip

    router_configs.each do |router_config|
      @default_routes[router_config] = router_config.find_default_routes
    end
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
    @last_time_active_at = nil
    @last_time_inactive_at = nil
    @time_by_status = { "active" => 0, "inactive" => 0 }
    current_time = Time.now
    current_status = @history.size > 0 ? @history[0].status : "active"

    if @history.size > 0
      @history.each do |item|
        if item.status != current_status
          @time_by_status[current_status] = @time_by_status[current_status] + (current_time - item.created_at)
          current_status = item.status
          current_time = item.created_at
        end

        @last_time_active_at = item.created_at if item.active? && @last_time_active_at.nil?
        @last_time_inactive_at = item.created_at if !item.active? && @last_time_inactive_at.nil?
      end

      @time_by_status[current_status] = @time_by_status[current_status] + (current_time - @history.last.created_at)
    end
  end

  private
  def set_router_config
    @router_config = RouterConfig.find(params[:id])
  end
end
