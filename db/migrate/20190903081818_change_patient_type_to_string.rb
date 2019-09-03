class ChangePatientTypeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :patients, :ward_assigned, :string
  end
end
