class ChangePatientTypeColumnToBeIntegerInPatients < ActiveRecord::Migration[5.2]

  def up
    change_column :patients, :patient_type, 'USING CAST(patient_type AS integer)', default: 0, index: true
  end

  def down
    change_column :patients, :patient_type, :string 
  end
end
