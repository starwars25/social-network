class Post < ActiveRecord::Base
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  has_many :likes, foreign_key: 'to_id'
  validates :content, presence: true, length: { maximum: 140 }
  mount_uploader :image, ImageUploader

  def liked?(user)
    !Like.where('from_id = (?) AND to_id = (?)', user.id, id)[0].nil?
  end
end
