require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  # test "the truth" do
  #   assert true
  # end

  test 'main test' do
    assert @user_one.active_posts.count == 0
    assert @user_one.passive_posts.count == 0
    assert @user_two.active_posts.count == 0
    assert @user_two.passive_posts.count == 0
    assert_difference 'Post.count', 1 do
      Post.create!(from_id: @user_one.id, to_id: @user_two.id, content: 'Lorem ipsum')
    end
    assert @user_one.active_posts.count == 1
    assert @user_one.passive_posts.count == 0
    assert @user_two.active_posts.count == 0
    assert @user_two.passive_posts.count == 1
  end
end
