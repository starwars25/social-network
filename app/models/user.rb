class User < ActiveRecord::Base
  before_save :downcase
  validates :username, presence: true, length: {minimum: 4, maximum: 20}, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, multiline: true}, uniqueness: {case_sensitive: false}



  private
  def downcase
    self.username = username.downcase
    self.email = email.downcase
  end
end
