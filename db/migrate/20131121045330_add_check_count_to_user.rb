class AddCheckCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :check_count, :integer
  end
end
