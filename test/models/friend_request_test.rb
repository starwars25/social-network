require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_one = users(:user_one)
    @user_two = users(:user_two)
  end

  test "main test" do
    assert_not FriendRequest.requested?(@user_one, @user_two)
    FriendRequest.request(@user_one, @user_two)
    assert FriendRequest.requested?(@user_one, @user_two)
  end
end
