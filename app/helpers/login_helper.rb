module LoginHelper

  def log_in(user)
    session[:user_id] = user.id
    session[:team_id] = user.team_id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    end
  end
  def current_team
    if (team_id = session[:team_id])
      @current_team ||= Team.find_by(id: team_id)
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    sessons.delete(:user_id)
    sessons.delete(:team_id)
    @current_user = nil
    @current_team = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
