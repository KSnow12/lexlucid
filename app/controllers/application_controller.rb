class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :require_login
  helper_method :current_user, :logged_in?

  protected

    def set_current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end

    def current_user
      @current_user
    end

    def logged_in?
      current_user.present?
    end

    def require_login
      return true if logged_in?

      flash[:error] = "Must be logged in"
      redirect_to '/login'
    end
end
