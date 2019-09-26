class AddAppointmentChargesToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :appointment_charge, :decimal, default: 0.0
  end
end
