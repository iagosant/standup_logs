class TeamsController < ApplicationController
  # attr_accessor :email, :name, :password, :password_confirmation, :team_name
  # before_filter :configure_permitted_parameters

  def new
    @team = Team.new
    @team.users.new
  end

  def create
    byebug
    @team = Team.create(team_params)
    @team.users.build(team_params[:users_attributes]["0"])
    # @user = User.new(user_params)
    if @team.save
      redirect_to root_path
    else
      redirect_to new_team_path
    end
  end

  private

  def team_params
    params.require(:team).permit(:team_name, users_attributes: [:first_name, :last_name, :email, :password, :password_confirmation, :role])
  end

end
