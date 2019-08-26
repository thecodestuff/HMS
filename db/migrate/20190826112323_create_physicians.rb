class CreatePhysicians < ActiveRecord::Migration[5.2]
  def change
    create_table :physicians do |t|
      t.references :user, index:true
      t.string :speciality
      t.string :shift

      t.timestamps
    end
  end
end
