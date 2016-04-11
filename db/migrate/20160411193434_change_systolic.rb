class ChangeSystolic < ActiveRecord::Migration
  def change
    add_column :bloodpressures, :min_diastolic, :float
    add_column :bloodpressures, :min_systolic, :float
    add_column :bloodpressures, :max_diastolic, :float
    add_column :bloodpressures, :max_systolic, :float
    add_column :bloodpressures, :average_diastolic, :float
    add_column :bloodpressures, :average_systolic, :float
    
    remove_column :bloodpressures, :min
    remove_column :bloodpressures, :max
    remove_column :bloodpressures, :average
  end
end
