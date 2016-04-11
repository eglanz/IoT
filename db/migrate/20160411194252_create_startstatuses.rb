class CreateStartstatuses < ActiveRecord::Migration
  def change
    create_table :startstatuses do |t|
      t.integer :start

      t.timestamps null: false
    end
  end
end
