class WipsController < ApplicationController
  before_filter :get_session, only: [:show]
  before_action :set_wip, only: [:show, :edit, :update, :destroy]

  def get_session
    @session = Session.find(params[:id])
  end

  # GET /wips
  # GET /wips.json
  def index
    @wips = @session.wips
  end

  # GET /wips/1
  # GET /wips/1.json
  def show
  end

  # GET /wips/new
  def new
    @wip = Wip.new
  end

  # GET /wips/1/edit
  def edit
  end

  # POST /wips
  # POST /wips.json
  def create
    @wip = Wip.new(wip_params)

    respond_to do |format|
      if @wip.save
        format.html { redirect_to @wip, notice: 'Wip was successfully created.' }
        format.json { render :show, status: :created, location: @wip }
      else
        format.html { render :new }
        format.json { render json: @wip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wips/1
  # PATCH/PUT /wips/1.json
  def update
    respond_to do |format|
      if @wip.update(wip_params)
        format.html { redirect_to @wip, notice: 'Wip was successfully updated.' }
        format.json { render :show, status: :ok, location: @wip }
      else
        format.html { render :edit }
        format.json { render json: @wip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wips/1
  # DELETE /wips/1.json
  def destroy
    @wip.destroy
    respond_to do |format|
      format.html { redirect_to wips_url, notice: 'Wip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wip
      @wip = Wip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wip_params
      params.require(:wip).permit(:session_id, :user_id, :wip_item)
    end
end
