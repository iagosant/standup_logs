class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def current_user

      @current_user ||= User.find_by(id: session[:user_id])

    end

    def require_logged_in

      return true if current_user
      redirect_to login_path
      return false

    end

    def user_not_authorized
        flash[:alert] = "Access denied."
        redirect_to (request.referrer || root_path)
    end
  end
