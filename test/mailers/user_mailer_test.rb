require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:admin)
    @user.activation_token = User.new_token
    @user.reset_token = User.new_token
  end

  test "account_activation" do
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["from@example.com"], mail.from
  end

  test "password_reset" do
    mail = UserMailer.password_reset(@user)
    assert_equal "Password reset", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["from@example.com"], mail.from

  end

end
