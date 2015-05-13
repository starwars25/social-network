class User < ActiveRecord::Base
  validates :username, presence: true, length: {minimum: 4, maximum: 20}
  VALID_EMAIL_REGEX = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, multiline: true}
end
