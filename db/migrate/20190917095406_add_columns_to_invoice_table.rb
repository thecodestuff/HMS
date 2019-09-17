class AddColumnsToInvoiceTable < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :bill_date, :date
    add_column :invoices, :admit_on,  :date
    add_column :invoices, :discharged, :date
    add_column :invoices, :days, :integer
    add_column :invoices, :appointments, :integer
  end
end
