class FirstAccessController < ApplicationController
  before_action :verify_first_access
  # GET /first_access/new
  def new
    @user = User.new
  end

  # POST /first_access
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
  def verify_first_access
    redirect_to root_path unless User.first_access?
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
