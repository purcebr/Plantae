class AddSuperuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_global_admin, :boolean, default: false, null: false
  end
end
