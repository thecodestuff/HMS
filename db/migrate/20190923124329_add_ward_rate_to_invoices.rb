class AddWardRateToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :ward_rate, :integer, default: 100
  end
end
