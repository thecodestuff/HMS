class AddColumnToPhysicina < ActiveRecord::Migration[5.2]
  def change
    add_column :physicinas, :charge_at_weekend, :decimal, default: 150.00
  end
end
