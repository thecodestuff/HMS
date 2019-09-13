class AddWardOccpancyDetailIdToWardOccupancyDetailTable < ActiveRecord::Migration[5.2]
  def change
    add_column :ward_occupancy_details, :ward_occupancy_detail_id, :integer, default: 0
  end
end
