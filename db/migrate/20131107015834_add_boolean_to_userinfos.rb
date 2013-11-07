class AddBooleanToUserinfos < ActiveRecord::Migration
  def change
    add_column :userinfos, :check, :boolean
  end
end
