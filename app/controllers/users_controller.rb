class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  attr_accessor :email, :name, :password, :password_confirmation

  def index
    this_user = User.find(session[:user_id])
    authorize this_user
    @users = User.all
  end

  def show
    # authorize @user
    #FIX SET USER
    @user = User.find(session[:user_id])
  end

  def new
    user = User.find(session[:user_id])
    authorize user
    @user = User.new
  end

  def edit
    authorize @user
    @user = User.find(params[:id])
  end



  def create
    user = User.find(session[:user_id])
    authorize user
    user_info = user_params
    temp_password = SecureRandom.hex(8)
    user_info[:password] = temp_password
    user_info[:password_confirmation] = temp_password
    @team = Team.find(session[:team_id])
    @user = @team.users.build(user_info)
    @user.save
    UserMailer.team_user(@user, temp_password).deliver_now
    flash[:info] = "Please check your email to activate your account."
    redirect_to sessions_path
  end

  def update
    this_user = User.find(params[:id])
    authorize this_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
      User.reset_pk_sequence
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not cool enough to do this - go back from whence you came."
    redirect_to(sessions_path)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @logged_user = User.find_by(session[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
end
