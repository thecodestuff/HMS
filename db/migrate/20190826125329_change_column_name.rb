class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    change_table :patients,{id:false} do |t|
      t.remove :user_id
    end

    change_table :physicians do |t|
      t.remove :user_id
    end
  end
end
