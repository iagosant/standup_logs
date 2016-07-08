class ApplicationController < ActionController::Base
  include LoginHelper
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def require_logged_in
      return true if current_user
      redirect_to sessions_path
      return false
    end

    def team_user_create(team_params)
      team_avatar = team_params[:avatar]
      # @team.avatar = team_avatar
      @team = Team.new(team_params)
      @team.save
      u_params = (team_params[:users_attributes]["0"])
      @user = @team.users.build(u_params)
      if @user.save
        @user.update(role: 1)
        UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_path
      end
    end

    def user_not_authorized
        flash[:alert] = "Access denied."
        redirect_to (request.referrer || root_path)
    end
  end
