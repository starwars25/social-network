class AddDialogIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :dialog_id, :integer
  end
end
