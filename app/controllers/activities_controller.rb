class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  def schedule_activity
    @project = Project.find(params[:project])
    if (params.has_key?(:location))
      @location = Location.find(params[:location])
    end
    if (params.has_key?(:time_slot))
      @time_slot = TimeSlot.find(params[:time_slot])
    end
    if (params.has_key?(:activity))
      @activity = Activity.find(params[:activity])
      @schedule = @activity
    else
      @schedule = Activity.new(:location => @location, :time_slot => @time_slot, :project => @project)
      @activity = nil
    end
  end

  def check_conflicts
    @project = Project.find(params[:project])
    if (params.has_key?(:location) && params[:location] != "")
      @location = Location.find(params[:location])
    end
    if (params.has_key?(:time_slot) && params[:time_slot] != "")
      @time_slot = TimeSlot.find(params[:time_slot])
    end
    if (params.has_key?(:activity))
      @activity = Activity.find(params[:activity])
    end

    @overlapping_time_slots = TimeSlot.where(:start => @time_slot.start..@time_slot.end)#.where.not(:id => @time_slot)
    #first if there is a location make sure the location does not have something in it
    if @location != nil && @overlapping_time_slots.size >0
      @conflicting_roomed_activities = Activity.where(:time_slot => @overlapping_time_slots).where(:location => @location)

      if @conflicting_roomed_activities.size > 0
        @room_conlict_status = true
      else
        @room_conlict_status = false
      end
    else
      @room_conlict_status = false
    end

    #eventually add room turnaroudn time buffer

    #eventually you have to add getting the particpants associated to the activity and 
    #checking for conflicts or adjacent activities beyond the warning buffer number of minutes
    #defined for the project

    msg = { :data => "ok", 
            :room_conflict => @room_conlict_status,
            :overlapping_time_slots => @overlapping_time_slots.to_json,
            :conflict_activity => @conflicting_roomed_activities.to_json,
            :html => "<b>...</b>" }
    render :json => msg 

  end

  def update_schedule
    @activity = Activity.find(params[:activity_id])

    #needs to double check for conflicts!!
    @activity.update(:location_id => params[:location_id])
    @activity.update(:time_slot_id => params[:time_slot_id])
    redirect_to @activity
  end

  # GET /activities/new
  def new
    @project = Project.find(params[:project])
    @activity = Activity.new(:project => @project)
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :time_slot_id, :location_id, :project_id)
    end
end
