require 'test_helper'

class AccountActivationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "should register and then activate" do
    assert_difference 'User.count', 1 do
      post users_path, user: {username: 'foobar', email: 'foo@bar.com', password: 'foobar', password_confirmation: 'foobar'}
    end
    assert flash[:success] = 'Please check your email to activate your account.'
    assert_redirected_to root_url
    user = assigns(:user)
    log_in_intergration(user)
    assert_not is_logged_in?
    assert_equal 1, ActionMailer::Base.deliveries.size
    get edit_account_activation_path('invalid token')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: 'email')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert is_logged_in?
  end
end
