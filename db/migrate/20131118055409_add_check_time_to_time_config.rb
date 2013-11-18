class AddCheckTimeToTimeConfig < ActiveRecord::Migration
  def change
    add_column :time_configs, :check_hour, :integer
    add_column :time_configs, :check_minutes, :integer
  end
end
