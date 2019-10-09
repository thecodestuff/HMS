class ChangeColumnDataTypeOfPhysicians < ActiveRecord::Migration[5.2]
  def change
    # for develoment
    #change_column :physicians, :charge, :decimal, using: 'charge::decimal', default: 100.00
    
    # production fix , revmove this in development
    add_column :physicians, :charge, :decimal, using: 'charge::decimal', default: 100.00
  end
end
