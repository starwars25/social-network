class Message < ActiveRecord::Base
  belongs_to :dialog
  belongs_to :user

  validates :content, presence: true, length: {maximum: 200}
end
