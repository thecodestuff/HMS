class ChangePatientTypeColumnToBeIntegerInPatients < ActiveRecord::Migration[5.2]

  def up
    change_column :patients, :patient_type, :integer, default: 0, index: true
  end

  def down
    change_column :patients, :patient_type, :string 
  end
end
