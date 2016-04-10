class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :patient_name
      t.string :video

      t.timestamps null: false
    end
  end
end
