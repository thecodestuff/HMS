class Admin::WardsController < ApplicationController
  def index
    @wards = WardOccupancyDetail.all
    @ward = WardOccupancyDetail.new
  end

  def create
    @ward = WardOccupancyDetail.create(ward_params)
    respond_to do |format|
      if @ward.save
        format.html { redirect_to admin_wards_path, notice: 'ward created success.' }
        format.js
      else 
        format.html { redirect_to admins_ward_path, notice: 'ward not created...'}
      end
    end
  end

  def destroy
    respond_to do |format|
      if WardOccupancyDetail.delete(params[:id])
        format.html { redirect_to admin_wards_path, notice: 'deleted success...' }
        format.js
      end
    end
  end

  private 
  def ward_params
    params.require(:ward_occupancy_detail).permit(
      :id,
      :ward_name,
      :ward_type,
      :status
    )
  end
end
