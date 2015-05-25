class AddLastMessageSendToDialogs < ActiveRecord::Migration
  def change
    add_column :dialogs, :last_message_send, :datetime
  end
end
