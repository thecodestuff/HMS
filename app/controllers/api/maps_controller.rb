class Api::MapsController < ApplicationController
  before_action :set_api_map, only: [:show, :edit, :update, :destroy]

  # GET /api/maps
  # GET /api/maps.json
  def index
    @api_maps = Api::Map.all
  end

  # GET /api/maps/1
  # GET /api/maps/1.json
  def show
  end

  # GET /api/maps/new
  def new
    @api_map = Api::Map.new
  end

  # GET /api/maps/1/edit
  def edit
  end

  # POST /api/maps
  # POST /api/maps.json
  def create
    @api_map = Api::Map.new(api_map_params)

    respond_to do |format|
      if @api_map.save
        format.html { redirect_to @api_map, notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @api_map }
      else
        format.html { render :new }
        format.json { render json: @api_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/maps/1
  # PATCH/PUT /api/maps/1.json
  def update
    respond_to do |format|
      if @api_map.update(api_map_params)
        format.html { redirect_to @api_map, notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_map }
      else
        format.html { render :edit }
        format.json { render json: @api_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/maps/1
  # DELETE /api/maps/1.json
  def destroy
    @api_map.destroy
    respond_to do |format|
      format.html { redirect_to api_maps_url, notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_map
      @api_map = Api::Map.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_map_params
      params.require(:api_map).permit(:name, :lat, :long)
    end
end
