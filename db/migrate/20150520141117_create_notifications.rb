class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :classification
      t.integer :user_id
      t.integer :dialog_id

      t.timestamps null: false
    end
  end
end
