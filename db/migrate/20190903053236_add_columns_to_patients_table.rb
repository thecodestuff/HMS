class AddColumnsToPatientsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :admit_date, :date 
    add_column :patients, :dischagre_on, :date
    remove_column :patients, :status
    add_column :patients, :status, :integer, default: 0
  end
end
