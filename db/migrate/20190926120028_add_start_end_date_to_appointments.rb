class AddStartEndDateToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :start_time, :datetime
  end
end
