require 'test_helper'

class AddingFriendsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'login, visit user, send request' do
    get root_url
    assert_template 'static_pages/home'
    get login_url
    assert_template 'sessions/new'
    post login_url, session: {email: @user_one.email, password: 'password'}
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert is_logged_in?
    get user_path(@user_two)
    assert_template 'users/show'
    assert_select 'form'
    assert_difference 'FriendRequest.count', 1 do
      post friend_requests_path, friend_request: {from_id: @user_one.id, to_id: @user_two.id}
    end
    assert_redirected_to user_path(@user_two)
    assert FriendRequest.requested?(@user_one, @user_two)
  end

end
