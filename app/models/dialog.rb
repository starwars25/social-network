class Dialog < ActiveRecord::Base
  has_many :dialog_relationships, foreign_key: 'dialog_id'
  has_many :users, through: :dialog_relationships, source: :user
  has_many :messages
end
