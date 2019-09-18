# frozen_string_literal: true

module Admin
  # Handles ward operation and status
  class WardsController < ApplicationController
    after_action :empty_ward, only: [:update]
    before_action :find_ward, only: %i[destroy update]

    def index
      @wards = WardOccupancyDetail.order('created_at DESC').page(params[:page])
      @ward = WardOccupancyDetail.new
    end

    def create
      @ward = WardOccupancyDetail.create(ward_params)
      respond_to do |format|
        format.html { redirect admins_ward_path, 'failed' } unless @ward.save
        format.html { redirect admin_wards_path, 'ward created success' }
        format.js
      end
    end

    def destroy
      redirect admin_wards_path, 'ward is not empty' && return unless @ward.empty?
      @ward.destroy
      respond_to do |format|
        format.html { redirect admin_wards_path, 'deleted success' }
        format.js
      end
    end

    def update
      respond_to do |format|
        @ward.update(status: 'EMPTY') if @ward.status == 'NOTEMPTY'
        format.html { redirect_to admin_wards_path }
        format.js
      end
    end

    private

    def ward_params
      params.require(:ward_occupancy_detail).permit(
        :id, :ward_name, :ward_type, :status
      )
    end

    def redirect(path, message)
      redirect_to path, notice: message
    end

    def find_ward
      @ward = WardOccupancyDetail.find(params[:id]) if params[:id].present?
    end

    def empty_ward
      if params[:id].present?
        @ward = WardOccupancyDetail.find(params[:id])
        @ward.update(status: 'empty')
      end
    end
  end
end
