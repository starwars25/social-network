class FriendRequest < ActiveRecord::Base
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'

  def FriendRequest.requested?(from, to)
    !FriendRequest.where('from_id = (?) AND to_id = (?)', from.id, to.id)[0].nil?
  end

  def FriendRequest.request(from, to)
    FriendRequest.create(from_id: from.id, to_id: to.id)
  end
end
