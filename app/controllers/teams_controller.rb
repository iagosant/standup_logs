class TeamsController < ApplicationController
  attr_accessor :email, :name, :password, :password_confirmation, :team_name
  # before_filter :configure_permitted_parameters

  def new
    @team = Team.new
  end

  def create
    byebug
    @team = Team.create.params[:team])
    @team.users.build
    # @user = User.new(user_params)
    if @team.save
      redirect_to root_path
    else
      redirect_to new_team_path
    end
  end

  private

  def team_params
    params.require(:team).permit(:team_name, user_params: [:first_name, :last_name, :email, :password, :password_confirmation, :role])
  end

end
