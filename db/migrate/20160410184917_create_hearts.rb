class CreateHearts < ActiveRecord::Migration
  def change
    create_table :hearts do |t|
      t.integer :testid
      t.float :min
      t.float :max
      t.float :average
      t.integer :type

      t.timestamps null: false
    end
  end
end
