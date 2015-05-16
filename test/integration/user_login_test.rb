require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  def setup
    @user = users(:admin)
  end

  test 'log in with remembering and than log out' do
    # get root_path
    # assert_template 'static_pages/home'
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: @user.email, password: 'admin', remember_me: '1'}
    assert_redirected_to root_url
    assert is_logged_in?
    # assert_not cookies[:user_id].nil?
    assert_not_nil cookies['remember_token']
    delete logout_path
    assert_redirected_to root_url
    # assert cookies.signed[:user_id].nil?
    assert cookies['remember_token'] == ""
  end
end
