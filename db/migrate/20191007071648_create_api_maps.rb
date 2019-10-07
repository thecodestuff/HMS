class CreateApiMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :api_maps do |t|
      t.string :name
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
