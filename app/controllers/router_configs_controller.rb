class RouterConfigsController < ApplicationController
  before_action :requires_login
  before_action :set_router_config, only: %i[ edit update destroy ]

  # GET /router_configs
  def index
    @router_configs = RouterConfig.all
  end

  # GET /router_configs/new
  def new
    @router_config = RouterConfig.new
  end

  # GET /router_configs/1/edit
  def edit
  end

  # POST /router_configs
  def create
    @router_config = RouterConfig.new(router_config_params)

    respond_to do |format|
      if @router_config.save
        format.html { redirect_to router_configs_path, notice: "Router config was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /router_configs/1
  def update
    respond_to do |format|
      if @router_config.update(router_config_params)
        format.html { redirect_to router_configs_path, notice: "Router config was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /router_configs/1
  def destroy
    @router_config.destroy!

    respond_to do |format|
      format.html { redirect_to router_configs_path, status: :see_other, notice: "Router config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_router_config
    @router_config = RouterConfig.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def router_config_params
    params.require(:router_config).permit(:name, :host, :port, :user, :password, :recurrent_checks, :notification_email, :max_check_entries)
  end
end
