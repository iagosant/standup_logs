class UsersController < ApplicationController
  before_action :require_logged_in
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  attr_accessor :email, :name, :password, :password_confirmation
  # before_filter :check_permissions, :only => [:new, :create, :cancel]
  # before_filter :autenticate_user!
  # after_action :verify_authorized

  # enum role: [:user, :editor, :admin]
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role | |= :user
  # end

  # attr_accessor :email, :name, :password, :password_confirmation

  # GET /users
  # GET /users.json
  def index
    this_user = User.find(session[:user_id])
    authorize this_user
    @users = User.all
    # @attended = User.attended
    # @recent = User.recent
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    this_user = User.find(session[:user_id])
    authorize this_user
    @user = User.new

  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  # POST /users.json

  # def check_permissions
  #     byebug
  # end

  def role_type

    if user_params[:role_type].to_i == 1
      @user.owner!
    else
      @user.player!
    end

  end

  def create

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
       WeeklyUpdate.sample_email(@user).deliver_now
        format.html { redirect_to new_user_path, :success => 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    # if !@user.admin? && @user.save
    # flash[:notice] = "Welcome, #{@user.username}!"
    # session[:user_id] = @user.id
    #
    # redirect_accordingly(@user)
    # else
    # flash[:alert] = "Some of the info you provided needs tweaking."
    # render :new
    # end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
    end

  end
