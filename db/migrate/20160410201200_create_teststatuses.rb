class CreateTeststatuses < ActiveRecord::Migration
  def change
    create_table :teststatuses do |t|
      t.integer :testid
      t.integer :status

      t.timestamps null: false
    end
  end
end
