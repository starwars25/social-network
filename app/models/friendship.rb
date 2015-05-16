class Friendship < ActiveRecord::Base
  belongs_to :from_friend, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to_friend, class_name: 'User', foreign_key: 'to_id'
end
