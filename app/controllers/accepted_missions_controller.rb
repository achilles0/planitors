class AcceptedMissionsController < ApplicationController
  before_action :set_accepted_mission, only: [:show, :edit, :update, :destroy]

  # GET /missions
  # GET /missions.json
  def index
    # Really a collection of accepted_missions
    @missions = current_user.accepted_missions.includes(:mission)
  end

  # POST /missions
  # POST /missions.json
  def create
    @accepted_mission = current_user.accepted_missions.build(mission_id: accepted_mission_params[:mission_id])

    respond_to do |format|
      if @accepted_mission.save
        format.html { redirect_to action: :index, notice: 'Mission has been accepted!' }
        format.json { render :show, status: :created, location: @accepted_mission }
      else
        #format.html { render :new }
        format.json { render json: @accepted_mission.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /missions/1
  # PATCH/PUT /missions/1.json
  def update
    respond_to do |format|
      if @accepted_mission.update(accepted_mission_params)
        format.html { redirect_to :back, notice: 'Accepted mission was successfully updated.' }
        format.json { render :show, status: :ok, location: @accepted_mission }
      else
        format.html { render :edit }
        format.json { render json: @accepted_mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  # def destroy
  #   @mission.destroy
  #   respond_to do |format|
  #     format.html { redirect_to missions_url, notice: 'Mission was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accepted_mission
      @accepted_mission = AcceptedMission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accepted_mission_params
      params.require(:accepted_mission).permit(:mission_id, :finished)
    end
end
