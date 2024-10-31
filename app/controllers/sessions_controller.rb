class SessionsController < ApplicationController
  before_action :requires_login, only: %i[ destroy ]

  def new
    redirect_to new_first_access_path if User.first_access?
  end

  def create
    @user = User.find_by(email: params[:email]&.downcase)

    if @user && @user.authenticate(params[:password])
      set_current_user(@user)
      redirect_to root_path, notice: "Welcome back #{@user.email}."
    else
      flash.now.alert = "Wrong email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    set_current_user(nil)
    redirect_to login_path, notice: "Successfully logged out."
  end
end
