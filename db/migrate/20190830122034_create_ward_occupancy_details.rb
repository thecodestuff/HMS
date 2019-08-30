class CreateWardOccupancyDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :ward_occupancy_details do |t|
      t.string :ward_name
      t.integer :ward_type, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
