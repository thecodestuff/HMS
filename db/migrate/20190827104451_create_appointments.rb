class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.belongs_to :physician
      t.belongs_to :patient

      t.timestamps
    end
  end
end
