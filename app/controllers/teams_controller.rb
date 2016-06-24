class TeamsController < ApplicationController
  # attr_accessor :email, :name, :password, :password_confirmation, :team_name
  # before_filter :configure_permitted_parameters

  def new
    @team = Team.new
    @team.users.new
  end

  def create
    team_user_create
  end

  private

  def team_params
    params.require(:team).permit(:team_name, users_attributes: [:first_name, :last_name, :email, :password, :password_confirmation, :role])
  end

end
