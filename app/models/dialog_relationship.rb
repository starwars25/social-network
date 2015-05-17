class DialogRelationship < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :dialog, foreign_key: 'dialog_id', class_name: 'Dialog'
end
