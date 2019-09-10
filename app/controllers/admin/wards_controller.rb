class Admin::WardsController < ApplicationController
  def index
    @wards = WardOccupancyDetail.all
    @ward = WardOccupancyDetail.new
  end

  def create
    @ward = WardOccupancyDetail.create(ward_params)
    respond_to do |format|
      format.html { redirect_to admins_ward_path, notice: 'ward not created...'} unless @ward.save
      format.html { redirect_to admin_wards_path, notice: 'ward created success.' }
      format.js
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

  def update
    @ward = WardOccupancyDetail.find(params[:id])
    respond_to do |format|
      if @ward.present?
        @ward.update(status: 'EMPTY') if @ward.status == 'NOTEMPTY'
        format.html { redirect_to admin_wards_path() }
        format.js
      end
    end
  end

  private

  def ward_params
    params.require(:ward_occupancy_detail).permit(
      :id, :ward_name, :ward_type, :status)
  end

  def redirect
    redirect_to 
  end
end
