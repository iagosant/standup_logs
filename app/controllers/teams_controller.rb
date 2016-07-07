class TeamsController < ApplicationController
  # attr_accessor :email, :name, :password, :password_confirmation, :team_name
  # before_filter :configure_permitted_parameters
  before_action :set_team, only: [:edit, :update]

  def new
    @team = Team.new
    @team.users.new
  end

  def create
    team_user_create(team_params)
  end

  def edit

  end

  def update
    team_avatar = params[:team][:avatar]
    @team.update(avatar: team_avatar)
    redirect_to edit_team_path
  end
  private

  # def set_team
  #   @team = Team.find(current_user.team.id)
  # end

  def team_params
    params.require(:team).permit(:team_name, :avatar, users_attributes: [:first_name, :last_name, :email, :password, :password_confirmation, :role])
  end

end
