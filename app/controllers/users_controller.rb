class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :create_activation_digest, only: [:create]
  before_action :downcase_email, only: [:save]
  attr_accessor :remember_token, :activation_token
  attr_accessor :email, :name, :password, :password_confirmation
  attr_accessor :remember_token, :activation_token, :reset_token

  def index
    this_user = User.find(session[:user_id])
    authorize this_user
    @users = User.all
  end

  def show
    authorize @user
  end

  def new
    # this_user = User.find(session[:user_id])
    # authorize this_user
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  FILL_IN,
    reset_sent_at: FILL_IN)
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        byebug
        UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
        # WeeklyUpdate.sample_email(@user).deliver_now
        # format.html { redirect_to new_user_path, :success => 'User was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def new_token
    byebug
    SecureRandom.urlsafe_base64
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def user_not_authorized
    flash[:alert] = "You are not cool enough to do this - go back from whence you came."
    redirect_to(sessions_path)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
end
