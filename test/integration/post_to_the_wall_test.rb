require 'test_helper'

class PostToTheWallTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test 'login, visit user, post' do
    post login_path, session: {email: @user_one.email, password: 'password'}
    assert is_logged_in?
    get user_path(@user_two)
    assert @user_two.feed.count == 0
    assert_difference 'Post.count', 1 do
      post posts_path, user: {id: @user_two.id}, current_user: {id: @user_one.id}, post: {content: 'Lorem ipsum'}
    end
    assert_redirected_to user_path(@user_two)
    assert @user_two.feed.count == 1
    assert_no_difference 'Post.count' do
      delete post_path(Post.last.id), user: @admin.id
    end

    assert_difference 'Post.count', -1 do
      delete post_path(Post.last.id), user: @user_one.id
    end

    assert_difference 'Post.count', 1 do
      post posts_path, user: {id: @user_two.id}, current_user: {id: @user_one.id}, post: {content: 'Lorem ipsum'}
    end

    assert_difference 'Post.count', -1 do
      delete post_path(Post.last.id), user: @user_two.id
    end
  end
end
