class CreateUserinfos < ActiveRecord::Migration
  def change
    create_table :userinfos do |t|

      t.string :name
      t.string :number
      t.timestamps
    end
  end
end
