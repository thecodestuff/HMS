class AddColoumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string , null: false , default:"general"
  end
end
