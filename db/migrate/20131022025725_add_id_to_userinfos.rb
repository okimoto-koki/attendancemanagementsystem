class AddIdToUserinfos < ActiveRecord::Migration
  def change
    add_column :userinfos, :userId, :integer
  end
end
