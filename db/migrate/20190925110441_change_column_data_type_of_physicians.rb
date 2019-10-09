class ChangeColumnDataTypeOfPhysicians < ActiveRecord::Migration[5.2]
  def change
    change_column :physicians, :charge, :decimal, using: 'charge::decimal', default: 100.00
  end
end
