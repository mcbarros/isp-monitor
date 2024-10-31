class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  private
  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def set_current_user(user)
    session[:current_user_id] = user.present? ? user.id : nil
  end

  def requires_login
    redirect_to(login_path) unless current_user.present?
  end
end
