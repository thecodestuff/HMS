class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.references :user, index: true
      t.string  :patient_type
      t.integer :ward_assigned
      t.boolean :status

      t.timestamps
    end
  end
end
