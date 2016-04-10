class ChangeType < ActiveRecord::Migration
  def change
    add_column :hearts, :bort, :integer
    add_column :bloodpressures, :bort, :integer
    
    remove_column :hearts, :type
    remove_column :bloodpressures, :type
  end
end
