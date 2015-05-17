class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase
  before_create :create_activation_digest
  validates :username, presence: true, length: {minimum: 4, maximum: 20}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, multiline: true}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 4}
  has_many :friendship_relations, class_name: 'Friendship', foreign_key: 'to_id', dependent: :destroy
  has_many :friends, through: 'friendship_relations', source: :from_friend
  has_many :friend_requests, foreign_key: 'to_id'
  has_many :active_posts, class_name: 'Post', foreign_key: 'from_id'
  has_many :passive_posts, class_name: 'Post', foreign_key: 'to_id'

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.friends?(user_one, user_two)
    user_one.is_friend?(user_two) && user_two.is_friend?(user_one)
  end

  def feed
    self.passive_posts.order(created_at: :desc)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Nice and simple example of Metaprogramming
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest, User.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def make_friends(user)
    raise 'Already friends' if User.friends?(self, user)
    Friendship.create(from_id: self.id, to_id: user.id)
    Friendship.create(from_id: user.id, to_id: self.id)
  end

  def unfriend(user)
    raise 'Not a friend' unless self.is_friend?(user)
    id = Friendship.where('from_id = (?) AND to_id = (?)', self.id, user.id)[0].id
    Friendship.find_by(id: id).destroy
    id = Friendship.where('from_id = (?) AND to_id = (?)', user.id, self.id)[0].id
    Friendship.find_by(id: id).destroy
    # Friendship.where(from_id: self.id, to_id: user.id).destroy
  end

  def is_friend?(user)
    friends.include? user
  end


  private
  def downcase
    self.username = username.downcase
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
