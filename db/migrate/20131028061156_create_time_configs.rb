class CreateTimeConfigs < ActiveRecord::Migration
  def change
    create_table :time_configs do |t|
      t.integer :youbi
      t.integer :start_hour
      t.integer :start_minitus
      t.integer :end_hour
      t.integer :end_minitus

      t.timestamps
    end
  end
end
