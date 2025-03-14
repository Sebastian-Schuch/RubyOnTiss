class ApplicationController < ActionController::Base
  helper_method :logged_in?
  helper_method :current_user
  helper_method :authenticate_user
  def logged_in?
    session[:user_id].present?
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    redirect_to login_path unless logged_in?
  end
end
