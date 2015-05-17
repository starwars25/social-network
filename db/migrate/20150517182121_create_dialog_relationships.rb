class CreateDialogRelationships < ActiveRecord::Migration
  def change
    create_table :dialog_relationships do |t|
      t.integer :user_id
      t.integer :dialog_id

      t.timestamps null: false
    end
  end
end
