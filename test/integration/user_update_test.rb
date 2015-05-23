require 'test_helper'

class UserUpdateTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_one = users(:user_one)
  end

  test 'update user' do
    log_in_intergration(@user_one)
    assert is_logged_in?
    get edit_user_path(@user_one)
    assert_template 'users/edit'
    assert @user_one.username == 'user_one'
    patch user_path(@user_one), user: {username: 'sanya'}
    assert_redirected_to profile_path
    @user_one.reload
    assert @user_one.username == 'sanya'
  end

end
