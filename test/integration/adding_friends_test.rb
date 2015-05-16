require 'test_helper'

class AddingFriendsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'login, visit user, send request, accept request, and then delete friend' do

    # get root_url
    # assert_template 'static_pages/home'
    # get login_url
    # assert_template 'sessions/new'
    post login_url, session: {email: @user_one.email, password: 'password'}
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert is_logged_in?
    get user_path(@user_two)
    assert_template 'users/show'
    assert_select 'form'
    assert_difference 'FriendRequest.count', 1 do
      post friend_requests_path, from_id: @user_one.id, to_id: @user_two.id
    end
    request = FriendRequest.last
    assert_redirected_to user_path(@user_two)
    assert FriendRequest.requested?(@user_one, @user_two)
    delete logout_path
    assert_not is_logged_in?
    get root_url
    get login_url
    post login_url, session: {email: @user_two.email, password: 'password'}
    assert is_logged_in?
    get profile_path
    assert_template 'static_pages/profile'
    assert_match 'Friend requests', response.body
    assert_difference 'Friendship.count', 2 do
      patch friend_request_path(request.id), from_id: @user_one.id, to_id: @user_two.id, friend_request: {choice: 'accept'}
    end
    assert_redirected_to root_url
    assert @user_one.is_friend?(@user_two)
    assert @user_two.is_friend?(@user_one)
    assert_not FriendRequest.requested?(@user_one, @user_two)
    get root_url
    assert_difference 'Friendship.count', -2 do
      post remove_friend_path, one: @user_two.id, two: @user_one.id
    end
    assert_redirected_to root_url
    assert_not @user_one.is_friend?(@user_two)
    assert_not @user_two.is_friend?(@user_one)
  end

  test 'login, visit user, send request, deny request' do
    # get root_url
    # assert_template 'static_pages/home'
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
      post friend_requests_path, from_id: @user_one.id, to_id: @user_two.id
    end
    request = FriendRequest.last
    assert_redirected_to user_path(@user_two)
    assert FriendRequest.requested?(@user_one, @user_two)
    delete logout_path
    assert_not is_logged_in?
    get root_url
    get login_url
    post login_url, session: {email: @user_two.email, password: 'password'}
    assert is_logged_in?
    get profile_path
    assert_template 'static_pages/profile'
    assert_match 'Friend requests', response.body
    assert_no_difference 'Friendship.count' do
      patch friend_request_path(request.id), from_id: @user_one.id, to_id: @user_two.id, friend_request: {choice: 'deny'}
    end
    assert_redirected_to root_url
    assert_not @user_one.is_friend?(@user_two)
    assert_not @user_two.is_friend?(@user_one)
    assert_not FriendRequest.requested?(@user_one, @user_two)
  end

end
