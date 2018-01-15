class TracksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_track, only: [:show, :edit, :update, :destroy, :getcoordinates]
  before_action :check_user_track, only: [:show, :edit, :update, :getcoordinates]
  before_action :update_track_json, only: [:show, :getcoordinates]

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.where(:user_id => current_user.id)
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
  end

  # GET /getcoordinates/1.json
  def getcoordinates
    render :json => @track.json_processed
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)
    @track.user_id = current_user.id

    if @track.valid?
      set_track_json
    end

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update    
    # @track.json_response = nil
    if @track.valid?
      set_track_json
    end

    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    if !is_user_track?
      @track.destroy
      respond_to do |format|
        format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title, :latitude_from, :longtitude_from, :latitude_to, :longtitude_to) #:user_id, :json_response, :json_processed
    end

    def is_user_track?
      @track.user_id != current_user.id
    end

    def check_user_track
      if is_user_track?
        redirect_to tracks_path
      end
    end

    def set_track_json
      requestUrl = "https://api.openrouteservice.org/directions?coordinates=#{@track.longtitude_from},#{@track.latitude_from}%7C#{@track.longtitude_to},#{@track.latitude_to}&profile=foot-hiking&preference=fastest&units=m&language=en&geometry=true&geometry_format=polyline&geometry_simplify=false&instructions=true&instructions_format=text&roundabout_exits=false&maneuvers=false&continue_straight=false&elevation=true&optimized=true&api_key={API_KEY}"
      @track.json_response = RestClient.get requestUrl

      parsed = JSON.parse(@track.json_response)
      @track.json_processed = parsed["routes"][0]["geometry"]
    end

    def update_track_json
      if @track.json_response.nil? || @track.json_response.empty? || @track.json_processed.nil? || @track.json_processed.empty?
        set_track_json
        @track.save
      end
    end
end
