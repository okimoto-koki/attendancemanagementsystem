class AddUserinfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :number, :string
  end
end
