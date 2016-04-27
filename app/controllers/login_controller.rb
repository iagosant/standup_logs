class LoginController < ApplicationController

  def new

  end

  def create

    user = User.find_by_email(params[:email])
    byebug
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to sessions_root_path, :notice => "Welcome back, #{user.username}"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to login_path

    end

  end

  def destroy

    reset_session
    flash[:info] = "Signed out successfully!"
    redirect_to login_path

  end

end
