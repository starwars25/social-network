class Dialog < ActiveRecord::Base
  has_many :dialog_relationships, foreign_key: 'dialog_id'
  has_many :members, through: :dialog_relationships, source: :user
  has_many :messages


  def add_member(user)
    raise 'Already a member' if has_member?(user)
    DialogRelationship.create(user_id: user.id, dialog_id: id)
  end

  def add_members(users)
    users.each do |user|
      add_member(user)
    end
  end

  def has_member?(user)
    members.include?(user)
  end

  def remove_member(user)
    DialogRelationship.where('user_id = (?) AND dialog_id = (?)', user.id, id)[0].destroy
  end

end
