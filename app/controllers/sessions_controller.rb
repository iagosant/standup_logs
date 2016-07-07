class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in

  def self.friday_recap
    @latest_session = Session.find(params[:id])
    @session_users = @latest_session.users
    @session_users.each do |user|
      blockers = []
      email = user.email
      user.blockers.where(user_id: user.id, session_id: @latest_session.id).each { |b| blockers << b.blocker  }
      WeeklyUpdate.send_mail(email, blockers).deliver_now
    end

  end

  def session_blockers
    @session_users.each do |user|
      @full_name = user.first_name
      @weeks_blockers = user.blockers.where(user_id: user.id, session_id: @session.id)
    end
  end

  def clean_date
    @team = Team.find(session[:team_id])
    date_select = params[:dateTypeVar]
    end_date = params[:dateTypeVarTwo]
    converted = date_select.to_time
    converted_end_date = end_date.to_time
    clean = Time.at(converted)
    clean_end_date = Time.at(converted_end_date)
    team_sessions = Session.where(team_id: @team.id)
    found_sessions = team_sessions.where(:created_at => clean..clean_end_date)
    search_results = Array.new
    found_sessions.each do |session|
      a = []
      a << session.id
      a << session.created_at
      search_results << a
    end
    # if search_results.nil?
    #   format.html {redirect_to :back, notice: "There are no sessions during the dates you selected."}
    # end
    respond_to do |format|
      format.html { redirect_to :back, notice: "success"}
      format.json {render json: search_results}
    end

  end

  def index

    @team = Team.find(session[:team_id])
    # if params[:dateTypeVar].nil?
      @sessions = @team.sessions.last(5)
  #   else
  #     @sessions = @search_results
  # end
  end

  def show
    @session = Session.find(params[:id])
    @session_users = @session.users
    @session_wips = @session.wips
    @session_completeds = @session.completeds
    @session_blockers = @session.blockers
    respond_to do |format|
      format.html
      format.json {render json: @session}
      format.xml {render xml: @session}
    end
  end

  def new
    @team = Team.find(session[:team_id])
    @session = Session.new
    @users = @team.users.all
  end

  def edit
    @users = User.all
  end

  def create
    @team = Team.find(session[:team_id])
    @users = Session.get_users(params[:user_ids].map{|i| i.to_i})
    @session = Session.create(users: @users, team_id: @team.id)
    respond_to do |format|
      if @session.save
        format.html { redirect_to @session}
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
    @users.each do |user|
      @new_wip = @session.wips.create
      user.wips << @new_wip

      @new_completed = @session.completeds.create
      user.completeds << @new_completed

      @new_blocker = @session.blockers.create
      user.blockers << @new_blocker
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
        redirect_to session_path
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
      Session.reset_pk_sequence
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:session).permit(:user_id, :dateTypeVar)
  end
end
