require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test "friend test" do
    @user_one.make_friends @user_two
    assert @user_one.is_friend? @user_two
    assert @user_two.is_friend? @user_one
    @user_one.unfriend @user_two
    assert_not @user_one.is_friend? @user_two
    assert_not @user_two.is_friend? @user_one
  end
end
