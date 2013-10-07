class AddTimeToUserinfos < ActiveRecord::Migration
  def change
    add_column :userinfos, :time, :datetime
  end
end
