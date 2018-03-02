class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :require_login
  helper_method :current_user, :logged_in?, :has_logged_in?

  protected

    def set_current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end

    def current_user
      @current_user
    end

    def has_logged_in?
      cookies[:email].present?
    end

    def logged_in?
      current_user.present?
    end

    def require_login
      return true if logged_in?

      flash[:error] = "Must be logged in"

      save_return_to_path
      redirect_to '/login'
    end

    def require_admin
      return true if logged_in? && current_user.admin?
      flash[:error] = "You do not have permission to view that page"
      redirect_to root_path
    end

    def save_return_to_path
      self.return_to_path = request.fullpath if request.get?
    end

    def return_to_path=(val)
      @return_to_path = session[:return_to_path] = val
    end

    def return_to_path
      @return_to_path || session[:return_to_path]
    end
end
