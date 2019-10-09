class AddColumnToPhysician < ActiveRecord::Migration[5.2]
  def change
    add_column :physicians, :charge_at_weekend, :decimal, default: 150.00
  end
end
