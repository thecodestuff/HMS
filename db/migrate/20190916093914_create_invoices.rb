class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :patient, index: true
      t.integer :transactionId
      t.decimal :amount, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
