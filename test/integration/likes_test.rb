require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin = users(:admin)
    @user_one = users(:user_one)
    @post = posts(:one)
  end

  test 'like post' do
    log_in_intergration(@user_one)
    assert is_logged_in?
    get user_path(@admin)
    assert_difference '@post.likes.count', 1 do
      xhr :post, likes_path, from_id: @user_one.id, to_id: @post.id
    end
    assert @post.likes.count == 1
    # Now unlike
    assert_difference '@post.likes.count', -1 do
      xhr :delete, unlike_path, from_id: @user_one.id, to_id: @post.id
    end
    assert @post.likes.count == 0
  end
end
