class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]


  # GET /sessions
  # GET /sessions.json

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

  def index

    @sessions = Session.all

  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show

    # SessionsController.friday_recap
    @session = Session.find(params[:id])
    @session_users = @session.users
    @session_blockers = @session.blockers
    @session_wips = @session.wips
    @session_completeds = @session.completeds

    respond_to do |format|
      format.html
      format.json {render json: @session}
      format.xml {render xml: @session}

    end

  end

  # GET /sessions/new
  def new

    @session = Session.new
    @users = User.all

  end

  # GET /sessions/1/edit
  def edit
    @users = User.all

  end

  # POST /sessions
  # POST /sessions.json
  def create
    @users = Session.get_users(params[:user_ids].map{|i| i.to_i})

    @session = Session.create(users: @users)

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
    @users.each do |user|
      @new_wip = Wip.create
      user.wips << @new_wip
      @session.wips << @new_wip

      @new_completed = Completed.create
      user.completeds << @new_completed
      @session.completeds << @new_completed

      @new_blocker = Blocker.create
      user.blockers << @new_blocker
      @session.blockers << @new_blocker
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    # @session = Session.find(params[:id]).update(users: Session.get_users(params[:user_ids].map{|i| i.to_i}))

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
      params.require(:session).permit(:user_id)
    end
end
