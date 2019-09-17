class ChangeDataTypeOfColumnInInvoiceTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :transactionId
    add_column :invoices, :transactionId, :string, default: ''
  end
end
