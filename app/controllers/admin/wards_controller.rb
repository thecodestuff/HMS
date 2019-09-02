class Admin::WardsController < ApplicationController
  def index
    @wards = WardOccupancyDetail.all
    @ward = WardOccupancyDetail.new
  end

  def create
    render html: params.to_s
  end
end
