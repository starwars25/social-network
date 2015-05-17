class Post < ActiveRecord::Base
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  validates :content, presence: true, length: {maximum: 140}
end
