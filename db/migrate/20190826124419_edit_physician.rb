class EditPhysician < ActiveRecord::Migration[5.2]
  def change
    change_table :physicians, id: false do |t|
      t.remove :id 
      t.primary_key :physician_id 
    end
  end
end
