class CreateSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :samples do |t|
      t.integer :patient_id
      t.decimal :amount
      t.integer :month
      t.timestamps
    end
  end
end
