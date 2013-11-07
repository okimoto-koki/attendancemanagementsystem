class AddActivationToTimeConfig < ActiveRecord::Migration
  def change
    add_column :time_configs, :activation, :integer
  end
end
