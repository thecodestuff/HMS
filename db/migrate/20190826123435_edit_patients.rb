class EditPatients < ActiveRecord::Migration[5.2]
  def change
    change_table :patients, id: false do |t|
      t.remove :id 
      t.primary_key :patient_id 
    end
  end
end
