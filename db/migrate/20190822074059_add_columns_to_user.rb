class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string ,null: false , default:""
    add_column :users, :lastname, :string , null: false , default:""
    add_column :users, :civil_id, :string , null: false , default:""
    add_column :users, :previlige_level,:integer , null: false , default:0
    add_column :users, :admin, :boolean , default: false 
    add_column :users, :department, :string , default:"general"
    add_column :users, :phone, :string 
    add_column :users, :blood_group, :string
    add_column :users, :age, :integer
    add_column :users, :house_no, :string
    add_column :users, :street, :string
    add_column :users, :locality, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :pincode, :string
    add_column :users, :country, :string
  end
end
