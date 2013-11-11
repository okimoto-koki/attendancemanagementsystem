class AddDatetimeToTimeConfig < ActiveRecord::Migration
  def change
    add_column :time_configs, :start_time, :datetime
    add_column :time_configs, :end_time, :datetime
  end
end
